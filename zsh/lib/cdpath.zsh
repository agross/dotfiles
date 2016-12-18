# Remove duplicates from global array $cdpath.
typeset -gaU cdpath

if [[ "$(platform)" == 'windows' ]]; then
  cdpath=(/gw /scratch /lab /lab/.NET /git-demos /gw/Kunden/*(N) $cdpath)
else
  cdpath=($HOME /etc $cdpath)
fi

# ZSH sets $CDPATH automatically from $cdpath.
verbose Setting $fg[yellow]\$CDPATH$reset_color to $fg[yellow]$cdpath$reset_color
