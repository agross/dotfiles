local brew=/usr/local/bin/brew # Intel.
[[ -x "$brew" ]] || brew=/opt/homebrew/bin/brew # Apple silicon.

if [[ -x "$brew" ]]; then
  eval "$("$brew" shellenv)"

  path=($HOMEBREW_CELLAR/*/*/libexec/gnubin(/N) $path)

  # No automatic updates for casks by homebrew-autoupdate. I use brew cu/bcu.
  export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
  export HOMEBREW_NO_UPGRADE_QUIT_CASKS=1
fi

unset brew
