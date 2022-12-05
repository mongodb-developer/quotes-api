#!/usr/bin/env bash

CURRENT_DIR=$(dirname "$(realpath "$0")")

atlas clusters search indexes create --clusterName "$GITPOD_WORKSPACE_ID" --file "$CURRENT_DIR/_search-index-definition.json"