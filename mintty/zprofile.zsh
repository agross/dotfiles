if is-mintty; then
  function _start-screen() {
    local template="$HOME/.screenrc"
    local config="$(mktemp)"
    local log="/tmp/screen-$HOST-$RANDOM.log"

    cat $template | sed "s|\$LOG|$log|g" > $config

    screen -c "$config" -L -S shared

    rm "$config" 2> /dev/null
    rm "$log" 2> /dev/null
  }

  verbose Starting $fg[green]screen$reset_color because we\'re running $fg[green]mintty$reset_color
  undefine-startup-functions

  _start-screen
  exit
fi
