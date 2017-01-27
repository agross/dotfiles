if [[ ! "$OSTYPE" == darwin* ]]; then
  return
fi

# Make sure homebrew zsh functions take precedence.
fpath=($(brew --prefix 2> /dev/null)/Cellar/zsh/$ZSH_VERSION/**/functions(/N) $fpath)
