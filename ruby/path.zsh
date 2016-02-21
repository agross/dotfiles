if [[ -d $HOME/.rvm/bin ]]; then
  path=($path $HOME/.rvm/bin)

  verbose Prepending $fg[yellow]$HOME/.rvm/bin$reset_color to $fg[yellow]\$PATH$reset_color
fi
