alias -g L='| less'
alias -g M='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g XA='| xargs'

alias -g DN='> /dev/null'
alias -g 2DN='2> /dev/null'
alias -g E2O='2>&1'

alias md='mkdir --parents'
alias grep='grep --color=auto --ignore-case --binary-files=without-match --line-number --initial-tab'
alias ls='ls --color=auto -l --all --human-readable --group-directories'
alias rmrf='rm --recursive --force'

# Also done by Ctrl + L.
alias cls='echo -ne "\033c"'
