# \e          escape sequence for escape (ESC)
# \a          escape sequence for bell (BEL)
# %n          expands to $USERNAME
# %m          expands to hostname up to first '.'
# %~          expands to directory, replacing $HOME with '~'
# There are many more expansions available: see the zshmisc man page.

verbose Setting up $fg[red]precmd$reset_color and $fg[red]preexec$reset_color hooks for $fg[yellow]$TERM$reset_color

# Disable oh-my-zsh's title support.
DISABLE_AUTO_TITLE="true"

case "$TERM" in
  xterm*|rxvt*|cygwin|screen)
    # Executed just after a command has been read and is about to be executed.
    function preexec() {
      if [[ -n $SSH_CONNECTION ]]; then
        # Print user@host and command line that is executed.
        print -Pn "\e]0;%n@$HOST: $1\a"
      else
        # Print command line that is executed.
        print -Pn "\e]0;$1\a"
      fi
    }

    # Executed before each prompt.
    function precmd() {
      if [[ -n $SSH_CONNECTION ]]; then
        # Print user@host and current path.
        print -Pn "\e]0;%n@$HOST: %~\a"
      else
        # Print current path.
        print -Pn "\e]0;%~\a"
      fi
    }

    # Executed whenever the current working directory is changed.
    function chpwd() {
    }
    ;;
esac
