#!/bin/sh

function git_is_git()
{
	local gitdir=$(git rev-parse --is-inside-work-tree 2>/dev/null)
	if [ $? -ne 0 ] || [ -z "$gitdir" ]; then
		return 1
	fi 

	# This is a Git repository.
	return 0
}

function git_has_changes_in_working_tree() 
{
	git diff --no-ext-diff --ignore-submodules --quiet --exit-code || return 0

	# No changes.
	return 1
}

function git_has_changes_in_index()
{
	git diff-index --cached --no-ext-diff --ignore-submodules --quiet HEAD -- || return 0

	# No changes.
	return 1
}

function git_has_untracked()
{
	if [ -n "$(git ls-files --others --exclude-standard)" ]; then
		# Has untracked files.
		return 0
	fi
	
	# No untracked files.
	return 1
}

function git_write_branch()
{
	__git_ps1 "@%s"
}

function git_write_dirty()
{
	git_is_git || return
	
	local -a status

	git_has_changes_in_working_tree	&& status+="*"
	git_has_untracked				&& status+="?"
	git_has_changes_in_index		&& status+="^"
	
	echo -n "$status"
}

function git_write_title()
{
	local title
	local isgit=git_is_git
	$isgit || title=$PWD
	$isgit && title="$(dirname "$(cygpath -a "$(__gitdir)")" | tr / \\n | tail -1)$(__git_ps1 "@%s")" 
	
	git_settitle "$title"
}

function git_settitle()
{
	echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

function git_settitle_old()
{
	case $TERM in
        cygwin*) local title="\[\033]0;$@\007\]";;
        *) local title=''
    esac

	local prompt=$(echo "$PS1" | sed -e 's/\\\[\\033\]0;.*\\007\\\]//')
    PS1="${title}${prompt}"
}