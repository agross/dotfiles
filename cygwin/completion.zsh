if [[ "$(platform)" != "windows" ]]; then
  return
fi

# Drives.
zstyle ':completion:*' fake-files   '/:c' '/:d'

# Use kill completion for wkill.
compdef wkill=kill
zstyle ':completion:*:*:wkill:*:processes' command "ps --user "$USER" --windows"
