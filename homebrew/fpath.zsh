if [[ ! "$OSTYPE" == darwin* ]]; then
  return
fi

# Add homebrew-installed zsh completions.
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

# Make sure homebrew zsh functions take precedence.
fpath=($HOMEBREW_CELLAR/zsh/$ZSH_VERSION/**/functions(/N) $fpath)
