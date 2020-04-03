# shellcheck disable=SC2148

[[ $OSTYPE == darwin* ]] || return

local bin_path="${0%/*}/bin"
path=($bin_path $path)

verbose Prepending $fg[yellow]$bin_path$reset_color to $fg[yellow]\$PATH$reset_color
