(($+commands[sudo])) || return 0

# This allows the usage of aliases with sudo.
# http://www.zsh.org/mla/users/2003/msg00411.html
alias sudo='command sudo '
