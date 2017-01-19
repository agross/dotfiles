# If a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

alias cd..='cd ..'

# cd into the directory of the most recent parameter.
# mkdir foo && touch foo/bar
# cdd # will cd into foo
alias cdd='cd "$(dirname $_)"'

# In conjunction with Tarrasch/zsh-bd.
(($+functions[bd])) && alias up='_() { bd ${1:-1} }; _'

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

# Don't push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# Easily switch between recent directories in the directory stack by entering
# their index of the output of 'dirs'.
alias dirs='dirs -v'
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'
