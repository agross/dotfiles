if ((!$+commands[ruby] && !$+commands[rvm])); then
  return
fi

if [[ "$(platform)" == "windows" ]]; then
  verbose Setting up Windows Ruby aliases

  # Initial Ruby aliases, call again if you installed new gems.
  update-ruby-aliases --no-verbose
fi

# Extra aliases with disabled zsh correction.
alias bun='nocorrect bundle'
alias bex='nocorrect bundle exec'
