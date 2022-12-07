if [[ ! "$OSTYPE" == darwin* ]]; then
  return
fi

path=($HOMEBREW_CELLAR/*/*/libexec/gnubin(/N) $path)

local bin_path="${0%/*}/bin"
path=($bin_path $path)
