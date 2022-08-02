# Only handle interactive SSH sesssions.
[[ -z $SSH_CONNECTION || -z $SSH_TTY ]] && return

if (($+commands[screen])); then
  if [[ -S $SSH_AUTH_SOCK && ! -h $SSH_AUTH_SOCK ]]; then
    verbose Symlinking $fg[yellow]$SSH_AUTH_SOCK$reset_color to \
            $fg[yellow]~/.ssh/ssh_auth_sock$reset_color
    ln -sf -- $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
  fi

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
