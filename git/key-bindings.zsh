zle -N git-log
bindkey '\el' git-log # ESC, l

zle -N git-status
bindkey '\es' git-status # ESC, s

zle -N git-diff-staged
bindkey '\ed' git-diff-staged # ESC, d
