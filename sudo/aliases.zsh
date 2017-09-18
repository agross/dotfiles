(($+commands[sudo])) || return 0

# This allows the usage of aliases with sudo.
# http://www.zsh.org/mla/users/2003/msg00411.html
if [[ ! -f /proc/syno_cpu_arch ]]; then
  alias sudo='command sudo '
fi

if [[ "$OSTYPE" == darwin* && -z "$SSH_CONNECTION" ]]; then
  export SUDO_ASKPASS="${0%/*}/sudo-askpass-keychain"
  alias sudo='command sudo -A '
fi
