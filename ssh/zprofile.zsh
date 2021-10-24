if [[ -n "$SSH_CONNECTION" ]]; then
  if [[ -n "$SSH_AUTH_SOCK" ]]; then
    verbose Symlinking $fg[yellow]$SSH_AUTH_SOCK$reset_color to $fg[yellow]$HOME/.ssh/ssh-agent-$USER-$HOSTNAME$reset_color
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-agent-$USER-$HOSTNAME"
  fi

  [[ -v NO_TERMINAL_MULTIPLEXER ]] && return 0

  if (($+commands[screen])); then
    verbose Starting $fg[red]screen$reset_color because we\'re connected using $fg[red]ssh$reset_color
    exec screen -dRq ssh
  fi

  # if (($+commands[tmux])) && [[ -z "$TMUX" ]]; then
  #   verbose Starting $fg[red]tmux$reset_color because we\'re connected using $fg[red]ssh$reset_color
  #   tmux has-session -t $USER 2> /dev/null && exec tmux attach-session -t $USER || exec tmux new-session -s $USER
  # fi
fi
