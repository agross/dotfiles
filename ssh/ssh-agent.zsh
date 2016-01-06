if [[ "$(platform)" == "windows" ]] && [[ -z "$SSH_CONNECTION" ]]; then
  # Unset SSH_AUTH_SOCK on Windows such that oh-my-zsh/plugins/ssh-agent does not symlink SSH_AUTH_SOCK to /tmp/ssh-agent-$USER-screen
  if [[ -n "$SSH_AGENT_PID" ]]; then
    verbose Unsetting user-specific system-wide export $fg[yellow]\$SSH_AGENT_PID$reset_color with $fg[yellow]$SSH_AGENT_PID$reset_color
    setx SSH_AGENT_PID "" > /dev/null
    unset SSH_AGENT_PID
  fi

  if [[ -n "$SSH_AUTH_SOCK" ]]; then
    verbose Unsetting user-specific system-wide export $fg[yellow]\$SSH_AUTH_SOCK$reset_color with $fg[yellow]$SSH_AUTH_SOCK$reset_color
    setx SSH_AUTH_SOCK "" > /dev/null
    unset SSH_AUTH_SOCK
  fi
fi

zstyle :omz:plugins:ssh-agent agent-forwarding on
