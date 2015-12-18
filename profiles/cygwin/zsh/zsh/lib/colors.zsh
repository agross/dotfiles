# `autoload -U' autoloads functions without alias expansion.
autoload -U colors zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
