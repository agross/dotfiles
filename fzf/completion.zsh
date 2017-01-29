(($+commands[fzf])) || (($+commands[fzf-tmux])) || return 0

if (($+commands[pt])); then
  export FZF_DEFAULT_COMMAND='pt --hidden --ignore .git -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  function _fzf_compgen_path() {
    eval $FZF_DEFAULT_COMMAND "$1"
  }
fi

export FZF_CTRL_R_OPTS='--exact'

if (($+commands[tree])); then
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n \$LINES'"
  export FZF_CTRL_T_OPTS="--preview '(cat {} || tree -C {}) 2> /dev/null | head -n \$LINES'"
fi

[[ -f ~/.fzf.zsh ]] || return 0
source ~/.fzf.zsh
