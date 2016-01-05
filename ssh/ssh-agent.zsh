if is-mintty; then
  verbose Disabling $fg[red]ssh agent$reset_color forwarding because we\'re running $fg[red]mintty$reset_color
  return
fi

zstyle :omz:plugins:ssh-agent agent-forwarding on
