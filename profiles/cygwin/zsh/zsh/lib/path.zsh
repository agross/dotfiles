# Remove duplicates from $path.
path=($HOME/bin(N) $HOME/bin/*/(/N) $path)

# ZSH sets $PATH automatically from $path.
verbose Setting $fg[yellow]\$PATH$reset_color to $fg[yellow]$path$reset_color
export PATH
