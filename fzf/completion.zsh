(($+commands[fzf])) || (($+commands[fzf-tmux])) || return 0

if (($+commands[pt])) && [[ $commands[pt] != *Program\ Files* ]]; then
  export FZF_DEFAULT_COMMAND='pt --hidden --ignore .git -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  function _fzf_compgen_path() {
    eval $FZF_DEFAULT_COMMAND "$1"
  }
fi

export FZF_DEFAULT_OPTS='
  --color=light
  --bind ctrl-j:preview-down,ctrl-k:preview-up
  --bind ctrl-h:preview-page-down,ctrl-l:preview-page-up
  --bind ctrl-p:toggle-preview
  --toggle-sort=\`
  --header "`: sort, Ctrl+P: preview, Ctrl+J,K,H,L: scroll preview"'

# --height is currently not supported on Windows.
if [[ $OSTYPE != cygwin* ]]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --height 80%"
fi

export FZF_CTRL_R_OPTS='--exact'

if (($+commands[tree])); then
  export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
  export FZF_CTRL_T_OPTS="--preview '(cat {} || tree -C {}) 2> /dev/null'"
fi

# SSH connections to Windows hosts yield 'character set not supported'.
[[ -n $SSH_CONNECTION && $OSTYPE == cygwin* ]] && return 0

[[ -f ~/.fzf.zsh ]] || return 0
source ~/.fzf.zsh
