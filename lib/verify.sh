#!/usr/bin/env bash
set -eo pipefail

# cd to parent dir of current script
cd "$(dirname "${BASH_SOURCE[0]}")"


set -x
bazelisk build //:debug-write-version
[[ "$(cat ./bazel-bin/version)" == "1.0.0" ]]
[[ "$(cat ./bazel-bin/version)" != "0.0.0" ]]
