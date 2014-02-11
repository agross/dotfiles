# Add function path.
fpath=($ZSH/functions $fpath)

# Autoload all functions from our functions path. Just execute the function,
# no need to autoload <function> before.
# See http://zsh.sourceforge.net/FAQ/zshfaq03.html, section 3.11.
autoload -Uz $ZSH/functions/*(:t)

# Add theme path.
fpath=($ZSH/themes $fpath)

# Automatically remove duplicates from these arrays.
typeset -U fpath

# Load all of the config files in ~/.zsh/lib that end in .zsh
for config_file ($ZSH/lib/*.zsh) source $config_file

# Load all of the plugins that were defined in ~/.zshrc
plugin=${plugin:=()}
for plugin ($plugins) source $ZSH/plugins/$plugin.plugin.zsh
