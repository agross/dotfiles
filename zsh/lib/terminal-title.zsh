# \e          escape sequence for escape (ESC)
# \a          escape sequence for bell (BEL)
# %n          expands to $USERNAME
# %m          expands to hostname up to first '.'
# %~          expands to directory, replacing $HOME with '~'
# There are many more expansions available: see the zshmisc man page.

_terminal-title::ssh-prefix() {
  if [[ -n $SSH_CONNECTION ]]; then
    print -n '%n@%m: '
  fi
}

_terminal-title::preexec() {
  # Executed just after a command has been read and is about to be executed.

  # Print command line that is executed, but expand aliases ($2 instead of $1).
  print -Pnf '\e]0;%s%s\a' "$(_terminal-title::ssh-prefix)" "$2"
}

_terminal-title::precmd() {
  # Executed before each prompt.

  local cwd="${PWD/#$HOME/~}"

  # Print current path.
  print -Pnf '\e]0;%s%s\a' "$(_terminal-title::ssh-prefix)" "$cwd"

  if [[ "$TERM" == screen* ]]; then
    # screen title as shown in windowlist, shortcut: ^A"
    print -Pnf '\ekzsh: %s%s\e\\' "$(_terminal-title::ssh-prefix)" "$cwd"
  fi
}

case "$TERM" in
  xterm*|rxvt*|cygwin|screen*)
    verbose Setting up $fg[red]precmd$reset_color and \
            $fg[red]preexec$reset_color hooks for $fg[yellow]$TERM$reset_color

    autoload -Uz add-zsh-hook
    add-zsh-hook preexec _terminal-title::preexec
    add-zsh-hook precmd _terminal-title::precmd
    ;;
esac
