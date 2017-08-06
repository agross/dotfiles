(($+commands[vlc])) || return 0

local bin_path="${0%/*}/bin"
path=($bin_path $path)
