(($+commands[ruby])) || return 0

# Aliases with disabled zsh correction.
alias bun='bundle'
alias bex='bundle exec'

[[ "$(platform)" == 'windows' ]] || return 0

verbose Setting up Windows Ruby aliases

# Initial Ruby aliases, call again if you installed new gems.
update-ruby-aliases --no-verbose
