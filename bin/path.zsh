# shellcheck disable=SC2148

local bin_path="${0%/*}"
path=($bin_path $path)

verbose Prepending $fg[yellow]$bin_path$reset_color to $fg[yellow]\$PATH$reset_color
