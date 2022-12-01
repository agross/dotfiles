# Remove duplicates from global array $path.
typeset -gaU path

path=($HOME/bin(N) $HOME/bin/*/(/N) $path)

if [[ -f /etc/debian_version ]]; then
  path=($path /usr/local/sbin /usr/sbin /sbin)
fi

# ZSH sets $PATH automatically from $path.
verbose Setting $fg[yellow]\$PATH$reset_color to $fg[yellow]$path$reset_color
