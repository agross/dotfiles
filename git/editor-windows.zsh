# Use Notepad++ as the git editor on Windows.

if [[ "$(platform)" != "windows" ]]; then
  return
fi

if [[ -n "$SSH_CONNECTION" ]]; then
  # SSH and Notepad++ won't work.
  return
fi

export GIT_EDITOR='file="$(cygpath --windows --absolute "$1")"; shift $#; /c/Tools/Notepad++/notepad++.exe -multiInst -nosession -notabbar -noPlugin "$file"'

# ST opens two windows when there is no instance of ST running.
# export GIT_EDITOR='file="$(cygpath --windows --absolute "$1")"; shift $#; /c/Tools/Sublime\ Text/subl.exe --wait --new-window "$file" --'
