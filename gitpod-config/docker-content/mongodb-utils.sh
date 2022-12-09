function atlas_up() {
  atlas setup --force --skipSampleData --skipMongosh --clusterName "$GITPOD_WORKSPACE_ID" > /tmp/cluster-info
  username=$(cat /tmp/cluster-info | grep Username | sed 's/.*:\s//')
  password=$(cat /tmp/cluster-info | grep Password | sed 's/.*:\s//')
  connectionstring=$(cat /tmp/cluster-info | grep string | sed 's/.*:\smongodb+srv:\/\///')
  rm /tmp/cluster-info
  local MONGODB_CONNECTION_STRING="mongodb+srv://$username:$password@$connectionstring"
  echo "MONGODB_CONNECTION_STRING=${MONGODB_CONNECTION_STRING}" > .env
  echo "$MONGODB_CONNECTION_STRING"
}

function atlas_down() {
  atlas clusters delete "$GITPOD_WORKSPACE_ID" --force
  # Remove .env file if it exists but ignore errors if it does not exist
  rm .env 2> /dev/null || true
}

function atlas_cleanup_when_done() {
  # https://github.com/gitpod-io/gitpod/issues/3966#issuecomment-1264520737
  trap 'atlas_down; exit' SIGTERM;
  printf '\033[3J\033c\033[3J%s\n' 'Waiting for SIGTERM ...';
  exec {sfd}<> <(:);
  until read -t 3600 -u $sfd; do continue; done;
}

export -f atlas_up
export -f atlas_down
export -f atlas_cleanup_when_done