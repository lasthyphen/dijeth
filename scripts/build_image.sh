#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Avalanche root directory
DIJETH_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )"; cd .. && pwd )

# Load the versions
source "$DIJETH_PATH"/scripts/versions.sh

# Load the constants
source "$DIJETH_PATH"/scripts/constants.sh

echo "Building Docker Image: $dockerhub_repo:$build_image_id based of $avalanche_version"
docker build -t "$dockerhub_repo:$build_image_id" "$DIJETH_PATH" -f "$DIJETH_PATH/Dockerfile" \
  --build-arg AVALANCHE_VERSION="$avalanche_version" \
  --build-arg DIJETH_COMMIT="$coreth_commit" \
  --build-arg CURRENT_BRANCH="$current_branch"
