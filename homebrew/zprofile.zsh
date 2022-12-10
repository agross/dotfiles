local brew=/usr/local/bin/brew # Intel.
[[ -x "$brew" ]] || brew=/opt/homebrew/bin/brew # Apple silicon.

if [[ -x "$brew" ]]; then
  eval "$("$brew" shellenv)"
fi

unset brew
