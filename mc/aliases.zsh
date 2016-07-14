if ((!$+commands[mc])); then
  return
fi

verbose Setting up $fg[red]mc$reset_color aliases

alias mc='mc --nosubshell'
