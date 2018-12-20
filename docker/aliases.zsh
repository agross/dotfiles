(($+commands[docker])) || return 0


if [[ $OSTYPE == darwin* ]]; then
  verbose Setting up $fg[red]docker$reset_color aliases

  alias moby='docker run --rm -it --privileged --pid=host walkerlee/nsenter -t 1 -m -u -i -n sh'
fi
