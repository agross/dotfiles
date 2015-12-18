if [[ "$(platform)" != "windows" ]]; then
  return
fi

# Have zsh automatically sync $cygwin and $CYGWIN, minus duplicates.
typeset -aUT CYGWIN cygwin ' '
cygwin=(nodosfilewarning)

verbose Setting $fg[yellow]\$CYGWIN$reset_color to $fg[yellow]$cygwin$reset_color
export CYGWIN
