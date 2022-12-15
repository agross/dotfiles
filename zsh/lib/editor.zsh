if [[ -z "$SSH_CONNECTION" ]] && (($+commands[code])); then
  local executables

  if executables=(${(f)"$(where code)"}); then
    # Exclude code from $DOTFILES.
    executables=(${executables##$DOTFILES*})

    if ((${#executables})); then
      export VISUAL=code
    fi
  fi

  unset executables
fi

if (($+commands[vim])); then
  export EDITOR=vim
fi
