# shellcheck disable=SC2148

(($+commands[dotnet])) || return 0

# https://github.com/dotnet/cli/issues/9321
path=($HOME/.dotnet/tools $path)
