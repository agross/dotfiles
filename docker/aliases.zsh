(($+commands[docker])) || return 0

verbose Setting up $fg[red]docker$reset_color aliases

alias dstats='docker stats $(docker ps --format={{.Names}})'
alias dpull='docker images --format="{{.Repository}}:{{.Tag}}" | command grep -v ":<none>" | xargs --no-run-if-empty --max-lines=1 docker pull'
