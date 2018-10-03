SPROMPT='%Bzsh:%b correct \
%B%F{red}%R%f%b to %B%F{green}%r%f%b? \
%U%B%F{blue}y%f%b%ues \
%U%B%F{blue}n%f%b%uo \
%U%B%F{blue}e%f%b%udit \
%U%B%F{blue}a%f%b%ubort '

# Try to correct the spelling of commands. Note that, when the HASH_LIST_ALL
# option is not set or when some directories in the path are not readable, this
# may falsely report spelling errors the first time some commands are used.
setopt correct

# Do not try to correct the spelling of all arguments in a line.
unsetopt correct_all
