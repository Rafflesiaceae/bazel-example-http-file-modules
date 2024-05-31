#!/usr/bin/env bash
set -eo pipefail

# cd to parent dir of current script
cd "$(dirname "${BASH_SOURCE[0]}")"


set -x

env GOOS=linux GOARCH=amd64 go build -o lib-srv.linux
env GOOS=darwin GOARCH=amd64 go build -o lib-srv.darwin
env GOOS=windows GOARCH=amd64 go build -o lib-srv.windows.exe

case "$(uname)" in
    Linux)
        bin=./lib-srv.linux
        ;;
    Darwin)  # macOS
        bin=./lib-srv.darwin
        ;;
    CYGWIN* | MINGW*)  # Windows
        bin=./lib-srv.windows.exe
        ;;
esac
"$bin" -p 41474 "$@"
