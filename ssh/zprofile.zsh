if [[ -n "$SSH_CONNECTION" ]] && (($+commands[screen])); then
  if [[ -n  "$SSH_AUTH_SOCK" ]]; then
    verbose Symlinking $fg[yellow]$SSH_AUTH_SOCK$reset_color to $fg[yellow]/tmp/ssh-agent-$USER-screen$reset_color
    ln -sf "$SSH_AUTH_SOCK" "/tmp/ssh-agent-$USER-screen"
  fi

  verbose Starting $fg[red]screen$reset_color because we\'re connected using $fg[red]ssh$reset_color
  /usr/bin/screen -dRq ssh && exit
fi
