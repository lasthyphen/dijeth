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

if [[ $# -eq 1 ]]; then
    binary_path=$1
elif [[ $# -ne 0 ]]; then
    echo "Invalid arguments to build coreth. Requires either no arguments (default) or one arguments to specify binary location."
    exit 1
fi

# Check if DIJETH_COMMIT is set, if not retrieve the last commit from the repo.
# This is used in the Dockerfile to allow a commit hash to be passed in without
# including the .git/ directory within the Docker image.
coreth_commit=${DIJETH_COMMIT:-$( git rev-list -1 HEAD )}

# Build Dijeth, which is run as a subprocess
echo "Building Dijeth Version: $coreth_version; GitCommit: $coreth_commit"
go build -ldflags "-X github.com/lasthyphen/dijeth/plugin/evm.GitCommit=$coreth_commit -X github.com/lasthyphen/dijeth/plugin/evm.Version=$coreth_version" -o "$binary_path" "plugin/"*.go
