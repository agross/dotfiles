[[ "$(platform)" == 'windows' ]] || return 0

# Some Cygwin programs like to produce stackdumps.
alias rsd='rm -f *.exe.stackdump'

(($+commands[cygstart])) || return 0

verbose Setting up $fg[red]cygstart$reset_color aliases
alias sudo='cygstart --action=runas'
