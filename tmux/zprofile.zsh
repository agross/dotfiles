(($+commands[tmux])) || return 0
[[ -z "$TMUX" ]] || return 0

if [[ -f /proc/version ]] && \
   grep --quiet Microsoft /proc/version; then
  [[ "$(umask)" == '000' ]] && umask 022

  export SHELL="$(which zsh)"

  exec tmux
fi
