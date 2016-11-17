path=($(brew --prefix)/Cellar/**/libexec/gnubin(N) $path)

# Remove duplicates from global array $manpath.
typeset -gaU manpath
manpath=($(brew --prefix)/Cellar/**/share/man(N) $manpath)
