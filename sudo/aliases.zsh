# This allows the usage of aliases with sudo.
# http://www.zsh.org/mla/users/2003/msg00411.html
(( $+commands[sudo] )) && alias sudo='command sudo '
