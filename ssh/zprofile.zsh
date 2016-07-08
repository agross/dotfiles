if [[ -n "$SSH_CONNECTION" ]] && (($+commands[screen])); then
  if [[ -n "$SSH_AUTH_SOCK" ]]; then
    verbose Symlinking $fg[yellow]$SSH_AUTH_SOCK$reset_color to $fg[yellow]$HOME/.ssh/ssh-agent-$USER-$HOSTNAME$reset_color
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-agent-$USER-$HOSTNAME"
  fi

  verbose Starting $fg[red]screen$reset_color because we\'re connected using $fg[red]ssh$reset_color
  exec /usr/bin/screen -dRq ssh
fi
