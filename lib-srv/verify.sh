#!/usr/bin/env bash
set -eo pipefail

# cd to parent dir of current script
cd "$(dirname "${BASH_SOURCE[0]}")"


set -x

./run.sh -v ./version

[[ "$(cat ./version)" == "1.0.0" ]]
[[ "$(cat ./version)" != "0.0.0" ]]

rm ./version
