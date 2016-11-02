if ((!$+commands[elixir])); then
  return
fi

if [[ "$(platform)" == "windows" ]]; then
  verbose Setting up Windows Elixir aliases

  # Initial Elixir aliases, call again if you installed new binaries.
  update-elixir-aliases --no-verbose
fi
