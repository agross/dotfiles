if [[ -n "$SSH_CONNECTION" ]]; then
  verbose Starting $fg[green]screen$reset_color because we\'re connected using $fg[green]ssh$reset_color
  /usr/bin/screen -dRq ssh && exit
fi
