# \e          escape sequence for escape (ESC)
# \a          escape sequence for bell (BEL)
# %n          expands to $USERNAME
# %m          expands to hostname up to first '.'
# %~          expands to directory, replacing $HOME with '~'
# There are many more expansions available: see the zshmisc man page.

case "$TERM" in
	xterm*|rxvt*|cygwin)
		# Executed just after a command has been read and is about to be executed.
		function preexec() {
			# Print command line that is executed.
			print -Pn "\e]0;$1\a"
		}

		# Executed before each prompt.
		function precmd() {
			# Print current path or git repo@branch.
			print -Pn "\e]0;%~\a"
		}

		# Executed whenever the current working directory is changed.
		function chpwd() {
		}
		;;

	screen*)
		function preexec() {
			local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]}
			echo -ne "\ek$CMD\e\\"
			print -Pn "\e]0;%n@%m: $1\a"  # xterm
		}

		function precmd() {
			echo -ne "\ekzsh\e\\"
			print -Pn "\e]0;%n@%m: %~\a"  # xterm
		}
		;;
esac
