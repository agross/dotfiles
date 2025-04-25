local brew=/usr/local/bin/brew # Intel.
[[ -x "$brew" ]] || brew=/opt/homebrew/bin/brew # Apple silicon.

if [[ -x "$brew" ]]; then
  eval "$("$brew" shellenv)"

  path=($HOMEBREW_CELLAR/*/*/libexec/gnubin(/N) $path)
fi

unset brew
