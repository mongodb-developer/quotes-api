# This file contains some utility functions that make it
# easier to work with MongoDB Atlas from inside the Gitpod environment.

export MONGODB_CLUSTER_NAME="${LOCAL_USER}-${HOSTNAME}"

# Spin up Atlas cluster for development
function atlas_up() {
  # setup Atlas and create a cluster named after the Gitpod Workspace
  # and save the result of the command in a temporary file
  atlas quickstart --force --skipSampleData --skipMongosh --clusterName "$MONGODB_CLUSTER_NAME" > /tmp/cluster-info
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
  atlas clusters delete "$MONGODB_CLUSTER_NAME" --force
  # Remove .env file if it exists but ignore errors if it does not exist
  rm .env 2> /dev/null || true
}

# All the functions are exported so they are available in the terminal
export -f atlas_up
export -f atlas_down