# Some cygwin programs like to produce stackdumps.
alias rsd='rm -f *.exe.stackdump'

if (( $+commands[cygstart] )); then
  verbose Setting up $fg[red]cygstart$reset_color aliases

  alias sudo='cygstart --action=runas'
fi
