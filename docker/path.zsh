if [[ -d ~/.docker/bin ]]; then
  path+=(~/.docker/bin)
fi

(($+commands[docker])) || return 0

local bin_path="${0%/*}/bin"
path=($bin_path $path)
