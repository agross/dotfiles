zstyle :omz:plugins:ssh-agent agent-forwarding on

# https://github.com/jirsbek/SSH-keys-in-macOS-Sierra-keychain
[[ "$(platform)" == 'mac' ]] && /usr/bin/ssh-add -A

[[ "$(platform)" == 'windows' && -z "$SSH_CONNECTION" ]] || return 0

# We started on Windows without coming through SSH.

# Unset SSH_AUTH_SOCK such that oh-my-zsh/plugins/ssh-agent does
# not symlink SSH_AUTH_SOCK to /tmp/ssh-agent-$USER-screen
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

# Check if the local SSH agent is still in a working state.
local ssh_env="$HOME/.ssh/environment-$HOST"
if [[ -f "$ssh_env" ]]; then
  local ssh_sock="$(sed -n 's/SSH_AUTH_SOCK=\([^;]*\);.*/\1/p' "$ssh_env")"

  if [[ -n "$ssh_sock" && ! -e "$ssh_sock" ]]; then
    # Socket points to a removed file, kill the running agent.
    local ssh_pid="$(sed -n 's/SSH_AGENT_PID=\([^;]*\);.*/\1/p' "$ssh_env")"

    if [[ -n ssh_pid ]]; then
      verbose Killing SSH agent with PID $fg[yellow]$ssh_pid$reset_color because socket $fg[yellow]$ssh_sock$reset_color does not exist

      kill -9 $ssh_pid 2> /dev/null
    fi

    unset ssh_pid

    # Invalidate environment config, forcing oh-my-zsh/plugins/ssh-agent to
    # start a new agent.
    rm -f "$ssh_env"
  fi

  unset ssh_sock
fi

unset ssh_env
