#!/usr/bin/env bash

CURRENT_DIR=$(dirname "$(realpath "$0")")

echo $CLUSTER_NAME

atlas clusters search indexes create --clusterName "${MONGODB_CLUSTER_NAME}" --file "$CURRENT_DIR/search-index-definition.json"