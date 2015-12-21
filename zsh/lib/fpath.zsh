# Find all topic/function directories, add them to $path and autoload these functions so you can just call them.
for topic_folder ($DOTFILES/*/functions(/)); do
  verbose Adding autoloaded function path $fg[green]$topic_folder$reset_color
  fpath=($topic_folder $fpath);

  # Autoload all functions from our functions path. Just execute the function,
  # no need to autoload <function> before.
  # See http://zsh.sourceforge.net/FAQ/zshfaq03.html, section 3.11.
  autoload -Uz $topic_folder/*(:t)
done
