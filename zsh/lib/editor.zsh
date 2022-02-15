if (($+commands[code])) && [[ ! -v SSH_CONNECTION ]]; then
  export EDITOR='code --new-window --wait'
elif (($+commands[vim])); then
  export EDITOR=vim
fi
