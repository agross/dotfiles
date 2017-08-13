# Additional completion directory.
fpath=(~/.zsh/completion $fpath)

# Find all topic/functions directories, add them to $fpath and autoload these
# functions so you can just call them.
local topic
for topic in $DOTFILES/*/functions(/N); do
  verbose Adding autoloaded function path $fg[green]$topic$reset_color
  fpath=($topic $fpath)

  # Autoload all functions from the topic/functions directory, excluding
  # directories without functions. Just execute the function, no need to
  # autoload <function> before.
  # See http://zsh.sourceforge.net/FAQ/zshfaq03.html, section 3.11.
  local funs=($topic/*(N:t))
  [[ ${#funs} -gt 0 ]] && autoload -Uz $funs
done
