if ((!$+commands[docker])); then
  return
fi

verbose Setting up $fg[red]docker$reset_color aliases

alias dstats='docker stats $(docker ps --format={{.Names}})'
