if [[ -n $SSH_CONNECTION ]]; then
  [[ -v NO_TERMINAL_MULTIPLEXER ]] && return 0

  if (($+commands[screen])); then
    verbose Starting $fg[red]screen$reset_color because we\'re connected \
            using $fg[red]ssh$reset_color

    # Synology does not support xterm-256color.
    [[ -f /proc/syno_cpu_arch ]] && export TERM=xterm

    exec screen -dRq ssh
  fi

  # if (($+commands[tmux])) && [[ -z "$TMUX" ]]; then
  #   verbose Starting $fg[red]tmux$reset_color because we\'re connected using $fg[red]ssh$reset_color
  #   tmux has-session -t $USER 2> /dev/null && exec tmux attach-session -t $USER || exec tmux new-session -s $USER
  # fi
fi
