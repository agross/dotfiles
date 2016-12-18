(($+commands[docker])) || return 0

verbose Setting up $fg[red]docker$reset_color aliases

alias dstats='docker stats $(docker ps --format={{.Names}})'
