(($+commands[systemctl])) || return 0

verbose Setting up $fg[red]systemd$reset_color aliases

alias sc=systemctl
alias scf='systemctl --failed'
