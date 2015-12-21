# \e          escape sequence for escape (ESC)
# \a          escape sequence for bell (BEL)
# %n          expands to $USERNAME
# %m          expands to hostname up to first '.'
# %~          expands to directory, replacing $HOME with '~'
# There are many more expansions available: see the zshmisc man page.

verbose Setting up $fg[red]precmd$reset_color and $fg[red]preexec$reset_color hooks for $fg[yellow]$TERM$reset_color

case "$TERM" in
  xterm*|rxvt*|cygwin|screen*)
    # Executed just after a command has been read and is about to be executed.
    function preexec() {
      if [[ -n $SSH_CONNECTION ]]; then
        local user_at_host="%n@$HOST: "
      fi

      # Print command line that is executed.
      print -Pn "\e]0;$user_at_host$1\a"
    }

    # Executed before each prompt.
    function precmd() {
      if [[ -n $SSH_CONNECTION ]]; then
        local user_at_host="%n@$HOST: "
      fi

      # Print current path.
      print -Pn "\e]0;$user_at_host%~\a"

      if [[ -n $STY ]]; then
        # screen title (in ^A").
        print -Pn "\ekzsh $user_at_host%~\e\\"
      fi
    }

    # Executed whenever the current working directory is changed.
    function chpwd() {
    }
    ;;
esac
