# shellcheck disable=SC2148

(($+commands[dotnet])) || return 0

# https://github.com/dotnet/cli/issues/9321
# Replace the bogus entry as tilde is ignored during path expansion.
path[${path[(ie)~/.dotnet/tools]}]=($HOME/.dotnet/tools)
