(($+commands[systemctl])) || return 0

verbose Setting up $fg[red]systemd$reset_color aliases

alias sc=systemctl
alias scf='systemctl --failed'
alias ju='journalctl --since="1 hour ago" --unit'
alias jf='journalctl --follow --unit'
