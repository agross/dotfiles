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

# Notepad++ with custom syntax.
# Files will be renamed to <name>.git before invoking Notepad++ and renamed
# to the original file name  after Notepad++ exited. Notepad++ has a custom
# syntax definition for *.git files:
# https://gist.github.com/agross/f1bbe96f5b073f20639c2d93d3144ab4
#
# export GIT_EDITOR='file="$(cygpath --windows --absolute "$1")"; shift $#; cp "$file" "$file.git" && /c/Tools/Notepad++/notepad++.exe -multiInst -nosession -noPlugins "$file.git" && mv "$file.git" "$file"'

# ST opens two windows when there is no instance of ST running.
# export GIT_EDITOR='file="$(cygpath --windows --absolute "$1")"; shift $#; /c/Tools/Sublime\ Text/subl.exe --wait --new-window "$file" --'
