if [[ "$(platform)" != "windows" ]]; then
  return
fi

# Have zsh automatically sync $cygwin and global exported $CYGWIN, minus duplicates.
typeset -gxaUT CYGWIN cygwin ' '
cygwin=(nodosfilewarning)

verbose Setting $fg[yellow]\$CYGWIN$reset_color to $fg[yellow]$CYGWIN$reset_color
