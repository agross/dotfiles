if [[ -n "$SSH_CONNECTION" ]]; then
  # SSH and visual editors won't work.
  return
fi

local executables

if executables=(${(f)"$(where code)"}); then
  # Exclude code from $DOTFILES.
  executables=(${executables##$DOTFILES*})

  if ((${#executables})); then
    verbose Found Visual Studio Code in $fg[yellow]$executables[1]$reset_color

    export GIT_EDITOR='code --new-window --wait'
  fi
fi

unset executables
