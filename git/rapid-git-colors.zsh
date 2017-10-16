[[ "$(platform)" == 'windows' ]] || return 0

typeset -gA RAPID_GIT_COLORS
RAPID_GIT_COLORS[reset]=$reset_color
RAPID_GIT_COLORS[branch]=$fg[green]
RAPID_GIT_COLORS[branch_index]=$fg[yellow]
RAPID_GIT_COLORS[branch_current]=$fg_bold[green]
RAPID_GIT_COLORS[branch_current_index]=$fg_bold[yellow]
RAPID_GIT_COLORS[status_index]=$fg_bold[yellow]
RAPID_GIT_COLORS[status_staged]=$fg_bold[red]
RAPID_GIT_COLORS[status_unstaged]=$fg_bold[green]
RAPID_GIT_COLORS[status_untracked]=$fg_bold[cyan]
RAPID_GIT_COLORS[status_unmerged]=$fg_bold[magenta]
RAPID_GIT_COLORS[mark_stage]=$fg[yellow]
RAPID_GIT_COLORS[mark_reset]=$fg[yellow]
RAPID_GIT_COLORS[mark_drop]=$fg[cyan]
RAPID_GIT_COLORS[mark_error]=$fg_bold[red]
