if [[ ! "$OSTYPE" == darwin* ]]; then
  return
fi

# Make sure homebrew zsh functions take precedence.
fpath=($HOMEBREW_CELLAR/zsh/$ZSH_VERSION/**/functions(/N) $fpath)
