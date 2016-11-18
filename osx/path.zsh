if [[ ! "$OSTYPE" == darwin* ]]; then
  return
fi

path=($(brew --prefix)/Cellar/**/libexec/gnubin(N) $path)
