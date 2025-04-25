if [[ ! "$OSTYPE" == darwin* ]]; then
  return
fi

local bin_path="${0%/*}/bin"
path=($bin_path $path)
