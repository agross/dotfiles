if (( ! $+commands[etckeeper] )); then
  return
fi

verbose Setting up $fg[red]etckeeper$reset_color aliases

alias  ec='sudo etckeeper'
alias  es='sudo etckeeper vcs status'
alias  ed='sudo etckeeper vcs diff'
alias edc='sudo etckeeper vcs diff --cached'
alias  el='sudo etckeeper vcs log --oneline --decorate --branches --all --graph'
alias  er='sudo etckeeper vcs log -1 --patch'
alias eci='sudo etckeeper commit'
alias edo='sudo etckeeper vcs'
