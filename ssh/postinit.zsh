if [[ "$(platform)" != "windows" ]]; then
  return
fi

# If we started an SSH agent on Windows, make the environment variables known
# system-wide for use with cmd.exe or Atom's git-plus. Otherwise unset them.
#
# Windows Explorer will listen on changes to the global environment variables
# and new processes started via Explorer will have the new environment variables
# available.

if ssh-agent-is-running; then
  verbose SSH agent is $fg[green]running$reset_color

  verbose Exporting user-specific system-wide $fg[yellow]\$SSH_AGENT_PID$reset_color as $fg[yellow]$SSH_AGENT_PID$reset_color
  setx SSH_AGENT_PID "$SSH_AGENT_PID" > /dev/null

  auth_sock="$(cygpath --windows "$SSH_AUTH_SOCK")"
  verbose Exporting user-specific system-wide $fg[yellow]\$SSH_AUTH_SOCK$reset_color as $fg[yellow]$auth_sock$reset_color
  setx SSH_AUTH_SOCK "$auth_sock" > /dev/null
  unset auth_sock
else
  verbose SSH agent is $fg[red]not running$reset_color

  if [[ -n "$SSH_AGENT_PID" ]]; then
    verbose Unsetting user-specific system-wide export $fg[yellow]\$SSH_AGENT_PID$reset_color
    setx SSH_AGENT_PID "" > /dev/null
    unset SSH_AGENT_PID
  fi

  if [[ -n "$SSH_AUTH_SOCK" ]]; then
    verbose Unsetting user-specific system-wide export $fg[yellow]\$SSH_AUTH_SOCK$reset_color
    setx SSH_AUTH_SOCK "" > /dev/null
    unset SSH_AUTH_SOCK
  fi
fi
