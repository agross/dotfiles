_prompt::dynamic() {
  local fun

  for fun in ${(i)functions[(I)_prompt-*]}; do
    $fun $@
  done
}

_prompt-1-user-host() {
  [[ $1 == --status ]] && echo -n '%F{green}%n@%m%f '
}

_prompt-2-cwd() {
  [[ $1 == --status ]] && echo -n '%F{yellow}%~%f '
}

_prompt-z-jobs() {
  [[ $1 == --status ]] && echo -n '%(1j|%B%F{magenta} %j job%(2j|s|)%f%b|)'
}

_prompt-z-exit-status() {
  [[ $1 == --success ]] && echo -n '$'
  [[ $1 == --error ]] && echo -n '%F{red}%K{white}%B%S↑%s%b%k%f'
}

function {
  # Disable replacing the current directory path generated by %~ (see
  # _prompt-2-cwd) with the variable name if the variable has the same
  # value as the absolute path to the current directory.
  unsetopt auto_name_dirs

  # Initialize of dynamic PROMPT parts.
  _prompt::dynamic --init

  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  local stat='%(?|$(_prompt::dynamic --success)|$(_prompt::dynamic --error))'

  # Start with newline.
  PROMPT=$'\n'
  PROMPT+='$(_prompt::dynamic --status)%E'
  PROMPT+=$'\n'
  PROMPT+="$stat %E"
}

# vim: set ft=zsh ts=2 sw=2 et:
