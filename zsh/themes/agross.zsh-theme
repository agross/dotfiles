_prompt::dynamic() {
  local fun

  for fun in ${(i)functions[(I)_prompt-*]}; do
    $fun $@
  done
}

_prompt-line-1-1-user-at-host() {
  [[ $1 == --status ]] && print -n '%F{green}%n@%m%f '
}

_prompt-line-1-2-cwd() {
  [[ $1 == --status ]] && print -n '%F{yellow}%~%f '
}

_prompt-line-1-z-jobs() {
  [[ $1 == --status ]] && print -n '%(1j|%B%F{magenta} %j job%(2j|s|)%f%b|)'
}

_prompt-line-1-zz-newline() {
  [[ $1 == --status ]] && print -n '%E\n'
}

_prompt-line-2-1-exit-status() {
  [[ $1 == --status ]] && print -n '%(?|$|%F{red}%K{white}%B%S↑%s%b%k%f)'
}

_prompt-line-2-2-cursor() {
  [[ $1 == --status ]] && print -n ' %E'
}

function {
  # Disable replacing the current directory path generated by %~ (see
  # _prompt-2-cwd) with the variable name if the variable has the same
  # value as the absolute path to the current directory.
  unsetopt auto_name_dirs

  # Initialize dynamic PROMPT parts.
  _prompt::dynamic --init

  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  # Start with newline.
  PROMPT=$'\n$(_prompt::dynamic --status)'
}

# vim: set ft=zsh ts=2 sw=2 et:
