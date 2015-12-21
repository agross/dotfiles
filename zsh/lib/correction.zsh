export SPROMPT='zsh: correct '%R' to '%r'? %Uy%ues/%Un%uo/%Ue%udit/%Ua%ubort '

# Try to correct the spelling of commands. Note that, when the HASH_LIST_ALL option is not set or when some directories in the path are not readable, this may falsely report spelling errors the first time some commands are used.
setopt correct

# Try to correct the spelling of all arguments in a line.
setopt correct_all

alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias git='nocorrect git'
alias svn='nocorrect svn'
alias ping='nocorrect ping'
