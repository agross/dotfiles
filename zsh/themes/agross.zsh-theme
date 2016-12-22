autoload -U zgitinit
zgitinit

autoload -U zgit-ext-rebaseinfo

function {
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  local history_index='%F{cyan}%h%f'
  local user_host='%F{green}%n@%m%f'
  local cwd='%F{yellow}$(_prompt::agross::cwd)%f'
  local git_branch='%F{green}$(_prompt::agross::git_branch)%f'
  local git_status_symbols='%B%F{red}$(_prompt::agross::git_status)%f%b'
  local jobs='%(1j|%B%F{magenta} %j job%(2j|s|)%f%b|)'
  local git_or_exit_status='%(?|$(_prompt::agross::symbol)|%F{red}%K{white}%B%S↑%s%b%k%f)'

  # Start with newline.
  PROMPT=$'\n'

  # Display history number on mintty terminals.
  if is-mintty; then
    verbose Enabling history index in $fg[yellow]\$PROMPT$reset_color because $fg[red]mintty$reset_color was started
    PROMPT+="$history_index "
  fi

  PROMPT+="$user_host $cwd $git_branch$git_status_symbols$jobs%E"
  PROMPT+=$'\n'
  PROMPT+="$git_or_exit_status %E"

  RPROMPT=
}

function _prompt::agross::cwd() {
  printf ${PWD/#$HOME/\~}
}

function _prompt::agross::symbol {
  zgit_isgit && printf '±' && return
  printf '$'
}

function _prompt::agross::git_branch() {
  zgit_isgit || return
  zgit-ext-rebaseinfo

  local extra

  zgit_ingitdir && extra='GIT_DIR! '
  zgit_isbare   && extra='BARE! '

  printf "$extra@$(zgit_head)$zgit_info[rebase]"
}

function _prompt::agross::git_status() {
  zgit_inworktree || return

  zgit_isworktreeclean || printf '*'
  zgit_hasuntracked    && printf '?'
  zgit_isindexclean    || printf '^'
  zgit_hasunmerged     && printf 'Y'
}

# vim:set filetype=sh:
