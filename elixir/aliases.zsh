(($+commands[elixir])) || return 0
[[ "$OSTYPE" =~ ^(msys|cygwin)$ ]] || return 0

verbose Setting up Windows Elixir aliases

# Initial Elixir aliases, call again if you installed new binaries.
update-elixir-aliases --no-verbose
