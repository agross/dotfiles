if (($+commands[code])) && [[ $commands[code] != ${DOTFILES}* ]]; then
  export VISUAL=code
fi

if (($+commands[vim])); then
  export EDITOR=vim
fi
