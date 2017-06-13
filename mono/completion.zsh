if [[ "$OS" != "Windows_NT" ]]; then
  # Required for paket completion.
  # https://unix.stackexchange.com/a/178054/72946
  compdef _precommand mono
fi
