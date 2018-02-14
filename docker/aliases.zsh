(($+commands[docker])) || return 0

verbose Setting up $fg[red]docker$reset_color aliases

alias dclean='docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi'
alias dhealth='docker inspect --format="{{json .State.Health}}"'
alias dpull='docker images --format="{{.Repository}}:{{.Tag}}" | command grep -v ":<none>" | xargs --no-run-if-empty --max-lines=1 docker pull'
alias drestart="docker ps --no-trunc --format='table {{.Image}} {{.Names}}' | command grep --extended-regexp '^sha256:[0-9a-f]{64}' | cut -d ' ' -f2 | cut -d _ -f 1 | sort | uniq | xargs --no-run-if-empty --verbose sudo systemctl restart"
alias dps="docker ps --format='table {{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Names}}\\t{{.Ports}}'"
alias dstats='docker stats $(docker ps --format={{.Names}})'

if [[ $OSTYPE == darwin* ]]; then
  alias moby='docker run --rm -it --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n sh'
fi
