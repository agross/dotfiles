if [[ "$(platform)" != "windows" ]]; then
  return
fi

typeset -gA RAPID_GIT_COLORS
RAPID_GIT_COLORS[reset]=$reset_color
RAPID_GIT_COLORS[branch]=$(git config --get-color color.branch.local 'cyan')
RAPID_GIT_COLORS[branch_index]=$fg[yellow]
RAPID_GIT_COLORS[branch_current]=$(git config --get-color color.branch.current 'bold cyan')
RAPID_GIT_COLORS[branch_current_index]=$fg_bold[yellow]
RAPID_GIT_COLORS[status_index]=$fg_bold[yellow]
RAPID_GIT_COLORS[status_staged]=$(git config --get-color color.status.added 'bold red')
RAPID_GIT_COLORS[status_unstaged]=$(git config --get-color color.status.changed 'bold green')
RAPID_GIT_COLORS[status_untracked]=$(git config --get-color color.status.untracked 'bold blue')
RAPID_GIT_COLORS[status_unmerged]=$fg_bold[magenta]
RAPID_GIT_COLORS[mark_stage]=$fg[yellow]
RAPID_GIT_COLORS[mark_reset]=$fg[yellow]
RAPID_GIT_COLORS[mark_drop]=$fg[cyan]
RAPID_GIT_COLORS[mark_error]=$fg_bold[red]
