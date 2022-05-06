#! /usr/bin/env sh

# Because we don't know which `code` binary is used, the Windows one or the current .vscode-server one.
exec code -w "$@"
