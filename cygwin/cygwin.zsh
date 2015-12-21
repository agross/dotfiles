if [[ "$(platform)" != "windows" ]]; then
  return
fi

# Have zsh automatically sync $cygwin and global $CYGWIN, minus duplicates.
typeset -gaUT CYGWIN cygwin ' '
cygwin=(nodosfilewarning)

verbose Setting $fg[yellow]\$CYGWIN$reset_color to $fg[yellow]$cygwin$reset_color
export CYGWIN
