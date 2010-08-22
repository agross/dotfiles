# The url-quote-magic line editing plugin automatically quotes metacharacters like question marks, quotes and ampersands while you type or paste them.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# List jobs in the long format by default. 
setopt long_list_jobs

# If querying the user before executing `rm *' or `rm path/*', first wait ten seconds and ignore anything typed in that time.
setopt rm_star_wait

# Run all background jobs at a lower priority. This option is set by default. 
unsetopt bg_nice

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt. 
unsetopt notify

export SPROMPT='zsh: correct '%R' to '%r'? %Uy%ues/%Un%uo/%Ue%udit/%Ua%ubort '

export PAGER=less
export LESS='--quit-at-eof --tabs=3 --LONG-PROMPT --quit-if-one-screen --RAW-CONTROL-CHARS --no-init'
export EDITOR=vi

export GREP_OPTIONS='--color=auto --ignore-case --binary-files=without-match --line-number --initial-tab'
export GREP_COLOR='1;32'

# Language settings: This variable determines the locale category for any category not specifically selected via a variable starting with `LC_'. 
export LANG=en_US.UTF-8

# no	NORMAL, NORM	Global default, although everything should be something
# fi	FILE	Normal file
# di	DIR	Directory
# ln	SYMLINK, LINK, LNK	Symbolic link. If you set this to ‘target’ instead of a numerical value, the color is as for the file pointed to.
# pi	FIFO, PIPE	Named pipe
# do	DOOR	Door
# bd	BLOCK, BLK	Black device
# cd	CHAR, CHR	Character device
# or	ORPHAN	Symbolic link pointing to a non-existent file
# so	SOCK	Socket
# su	SETUID	File that is setuid (u+s)
# sg	SETGID	File that is setgid (g+s)
# tw	STICKY_OTHER_WRITABLE	Directory that is sticky and other-writable (+t,o+w)
# ow	OTHER_WRITABLE	Directory that is other-writable (o+w) and not sticky
# st	STICKY	Directory with the sticky bit set (+t) and not other-writable
# ex	EXEC	Executable file (i.e. has ‘x’ set in permissions)
# mi	MISSING	Non-existent file pointed to by a symbolic link (visible when you type ls -l)
# lc	LEFTCODE, LEFT	Opening terminal code
# rc	RIGHTCODE, RIGHT	Closing terminal code
# ec	ENDCODE, END	Non-filename text
# *.extension	 	Every file using this extension e.g. *.jpg
#
# The keys (above) are assigned a colour pattern which is a semi-colon separated list of colour codes.
# Effects
# 00	Default colour
# 01	Bold
# 04	Underlined
# 05	Flashing text
# 07	Reversetd
# 08	Concealed
# Colours
# 31	Red
# 32	Green
# 33	Orange
# 34	Blue
# 35	Purple
# 36	Cyan
# 37	Grey
# Backgrounds
# 40	Black background
# 41	Red background
# 42	Green background
# 43	Orange background
# 44	Blue background
# 45	Purple background
# 46	Cyan background
# 47	Grey background
# Extra colours
# 90	Dark grey
# 91	Light red
# 92	Light green
# 93	Yellow
# 94	Light blue
# 95	Light purple
# 96	Turquoise
# 97	White
# 100	Dark grey background
# 101	Light red background
# 102	Light green background
# 103	Yellow background
# 104	Light blue background
# 105	Light purple background
# 106	Turquoise background
export LS_COLORS='no=00:fi=00:di=01;35:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33:ex=01;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mov=01;35:*.mpg=01;35:*.png=01;35:*.tga=01;35:*.tif=01;35:*.wmv=01;35:*.mp3=00;32:*.ogg=00;32:*.wav=00;32:'