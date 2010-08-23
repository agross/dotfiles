# Add function path.
fpath=($ZSH/functions $fpath)

# Add theme path.
fpath=($ZSH/themes $fpath)

# Automatically remove duplicates from these arrays.
typeset -U fpath

# Load all of the config files in ~/.zsh/lib that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file