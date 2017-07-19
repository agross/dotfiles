(($+commands[systemctl])) || return 0

verbose Setting up $fg[red]systemd$reset_color aliases

alias sc=systemctl
alias scf='systemctl --failed'
alias jf='_() {
  local arg
  local -a args
  for arg in $@; do
    if [[ $arg != -* ]] then
      args+=(--unit $arg)
    else
      args+=($arg)
    fi
  done
  journalctl --follow ${args[@]}
}
_'
