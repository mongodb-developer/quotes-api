# This file contains some utility functions that make it
# easier to work with MongoDB Atlas from inside the Gitpod environment.

# Spin up Atlas cluster for development
function atlas_up() {
  # setup Atlas and create a cluster named after the Gitpod Workspace
  # and save the result of the command in a temporary file
  atlas setup --force --skipSampleData --skipMongosh --clusterName "$GITPOD_WORKSPACE_ID" > /tmp/cluster-info
  # extract MongoDB credentials and connection string (https://www.mongodb.com/docs/manual/reference/connection-string/)
  # from the output of the command above
  username=$(cat /tmp/cluster-info | grep Username | sed 's/.*:\s//')
  password=$(cat /tmp/cluster-info | grep Password | sed 's/.*:\s//')
  connectionstring=$(cat /tmp/cluster-info | grep string | sed 's/.*:\smongodb+srv:\/\///')
  # remove temporary file
  rm /tmp/cluster-info
  # build the connection string with credentials
  local MONGODB_CONNECTION_STRING="mongodb+srv://$username:$password@$connectionstring"
  # save the connection string in a dotenv file
  # so tools and applications can load it from there
  echo "MONGODB_CONNECTION_STRING=${MONGODB_CONNECTION_STRING}" > .env
  echo "$MONGODB_CONNECTION_STRING"
}

# Tear down Atlas cluster
# Note: this function only deletes the cluster but does not clean up the network access rules.
#       This is an improvement that should be added here.
function atlas_down() {
  atlas clusters delete "$GITPOD_WORKSPACE_ID" --force
  # Remove .env file if it exists but ignore errors if it does not exist
  rm .env 2> /dev/null || true
}

# Workaround for Gitpod not yet having a tear down hook:
# this function, invoked in the .gitpod.yml file when the workspace is created, sets up
# a trap that listens for the SIGTERM that is sent when the workspace is stopped.
# Then it just waits for the signal to arrive and at that point it invokes atlas_down.
function atlas_cleanup_when_done() {
  # https://github.com/gitpod-io/gitpod/issues/3966#issuecomment-1264520737
  trap 'atlas_down; exit' SIGTERM;
  printf '\033[3J\033c\033[3J%s\n' 'Waiting for SIGTERM ...';
  exec {sfd}<> <(:);
  until read -t 3600 -u $sfd; do continue; done;
}

# All the functions are exported so they are available in the Gitpod terminal
# as well as callable from .gitpod.yml.
export -f atlas_up
export -f atlas_down
export -f atlas_cleanup_when_done