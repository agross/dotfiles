(($+commands[elixir])) || return 0

if [[ "$(platform)" == "windows" ]]; then
  verbose Setting up Windows Elixir aliases

  # Initial Elixir aliases, call again if you installed new binaries.
  fpath=(${0%/*}/functions $fpath)
  autoload -Uz update-elixir-aliases && update-elixir-aliases --no-verbose
fi
