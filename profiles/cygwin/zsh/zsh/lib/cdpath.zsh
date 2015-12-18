# Remove duplicates from $cdpath.
typeset -U cdpath

if [[ "$(platform)" == "windows" ]]; then
  cdpath=(/gw /scratch /lab /lab/.NET /git-demos /gw/Kunden/*)
else
  cdpath=($HOME /etc /opt/jetbrains)
fi

# ZSH sets $CDPATH automatically from $cdpath.
verbose Setting $fg[yellow]\$CDPATH$reset_color to $fg[yellow]$cdpath$reset_color
