(($+commands[ruby])) || return 0

if [[ "$(platform)" == "windows" ]]; then
  verbose Setting up Windows Ruby aliases

  # Initial Ruby aliases, call again if you installed new gems.
  fpath=(${0%/*}/functions $fpath)
  autoload -Uz update-ruby-aliases && update-ruby-aliases --no-verbose
fi

# Extra aliases with disabled zsh correction.
alias bun='nocorrect bundle'
alias bex='nocorrect bundle exec'
