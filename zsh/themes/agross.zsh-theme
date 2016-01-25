autoload -U zgitinit
zgitinit

autoload -U zgit-ext-rebaseinfo

function {
  local history_index="%{$fg[cyan]%}%h%{$reset_color%}"
  local user_host="%{$fg[green]%}%n@%m%{$reset_color%}"
  local cwd="%{$fg[yellow]%}\$(_prompt_agross_cwd)%{$reset_color%}"
  local git_branch="%{$fg[green]%}\$(_prompt_agross_scm_branch)%{$reset_color%}"
  local git_status_symbols="%{$fg_bold[red]%}\$(_prompt_agross_scm_status)%{$reset_color%}"
  local jobs="%(1j.%{$fg_bold[magenta]%} %j jobs%{$reset_color%}.)"
  local git_or_exit_status="%(?.\$(_prompt_agross_symbol).%{$fg_bold[red]%}%S↑%s%{$reset_color%})"

  # Start with newline.
  PROMPT='
'
  # Display history number on mintty terminals.
  if is-mintty; then
    verbose Enabling history index in $fg[yellow]\$PROMPT$reset_color because mintty was started
    PROMPT+="$history_index "
  fi

  PROMPT+="$user_host $cwd $git_branch$git_status_symbols$jobs%E
$git_or_exit_status "

  RPROMPT=''
}

function _prompt_agross_cwd() {
  echo -n ${PWD/#$HOME/\~}
}

function _prompt_agross_scm_branch() {
  zgit_isgit || return
  zgit-ext-rebaseinfo

  local extra=''

  if zgit_ingitdir; then
    extra='GIT_DIR! '
  fi

  if zgit_isbare; then
    extra='BARE! '
  fi

  echo -n "$extra@$(zgit_head)$zgit_info[rebase]"
}

function _prompt_agross_symbol {
  zgit_isgit && echo '±' && return
  echo '$'
}

function _prompt_agross_scm_status() {
  zgit_inworktree || return

  if ! zgit_isworktreeclean; then
    echo -n '*'
  fi

  if zgit_hasuntracked; then
    echo -n '?'
  fi

  if ! zgit_isindexclean; then
    echo -n "^"
  fi

  if zgit_hasunmerged; then
    echo -n 'Y'
  fi
}
