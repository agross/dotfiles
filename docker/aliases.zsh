(($+commands[docker])) || return 0

verbose Setting up $fg[red]docker$reset_color aliases

alias dclean='docker image prune --all --force'

if [[ $OSTYPE == darwin* ]]; then
  alias moby='docker run --rm -it --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n sh'
fi
