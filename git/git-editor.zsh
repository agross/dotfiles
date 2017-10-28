if [[ -n "$SSH_CONNECTION" ]]; then
  # SSH and visual editors won't work.
  return
fi

case "$OSTYPE" in
  cygwin)
    # Visual Studio Code.
    export GIT_EDITOR='file="$(cygpath --windows --absolute "$1")"; shift $#; /c/Tools/Code/bin/code --new-window --wait "$file"'
    ;;

  linux*)
    if [[ -f /proc/version ]] && \
       grep --quiet Microsoft /proc/version && \
       [[ -f /mnt/c/Tools/Code/bin/code ]]; then
      # Visual Studio Code on WSL, there currently is nothing like cygpath, so try with relative paths.
      export GIT_EDITOR='file="$(realpath --relative-to=. "$1")"; shift $#; /mnt/c/Tools/Code/bin/code --new-window --wait "$file"'
    fi
    # Fall through.
    ;&

  *)
    (($+commands[code])) && export GIT_EDITOR='code --new-window --wait'
    return 0
    ;;
esac

# Notepad++ with custom syntax.
# Files will be renamed to <name>.git before invoking Notepad++ and renamed
# to the original file name  after Notepad++ exited. Notepad++ has a custom
# syntax definition for *.git files:
# https://gist.github.com/agross/f1bbe96f5b073f20639c2d93d3144ab4
#
# export GIT_EDITOR='file="$(cygpath --windows --absolute "$1")"; shift $#; cp "$file" "$file.git" && /c/Tools/Notepad++/notepad++.exe -multiInst -nosession -noPlugins "$file.git" && mv "$file.git" "$file"'

# ST opens two windows when there is no instance of ST running.
# export GIT_EDITOR='file="$(cygpath --windows --absolute "$1")"; shift $#; /c/Tools/Sublime\ Text/subl.exe --wait --new-window "$file" --'
