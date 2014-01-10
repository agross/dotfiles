#!/bin/sh
#
# export GIT_DIFFMERGE_VERBOSE=1 to enable logging
#

function get_cygpath()
{
  local __result=$1
  local cygpath=$(command -v cygpath)

  if [ "x$cygpath" = "x" ]; then
    cygpath=/D/Development/Repository/tools/Git/cygpath
  fi

  if [ -n "${GIT_DIFFMERGE_VERBOSE-}" ]; then
    echo "Cygpath: $cygpath"
  fi

  if [[ "$__result" ]]; then
    eval $__result="'$cygpath'"
  else
    echo "$cygpath"
  fi
}

function get_tool_path()
{
  local __result=$1
  local path
  get_cygpath path

  local tool=$($path $2)

  if [ -n "${GIT_DIFFMERGE_VERBOSE-}" ]; then
    echo "Tool: $2 -> $tool"
  fi

  if [[ "$__result" ]]; then
    eval $__result="'$tool'"
  else
    echo "$tool"
  fi
}

# Sets global variables: old, old_title, new, new_title
function get_diff_args()
{
  local path
  get_cygpath path

  old=$($path --mixed --absolute "$1")
  local old_unix=$($path --unix --absolute "$1")
  # Extract file name from git's temporary file: /tmp/<garbage>_filename
  old_title="Old $(echo $1 | cut -d'_' -f 2-)"
  if [ ! -f "$old_unix" ]; then
    old=$($path --mixed --absolute ~/bin/git/tools/empty)
    old_title="<File didn't exist>"
  fi

  new=$($path --mixed --absolute "$2")
  local new_unix=$($path --unix --absolute "$2")
  new_title="New $2"
  if [ ! -f "$new_unix" ]; then
    new=$($path --mixed --absolute ~/bin/git/tools/empty)
    new_title="<File has been deleted>"
  fi

  if [ ! -f "$new_unix" ]; then
    # Extract file name from git's temporary file: /tmp/<garbage>_filename
    old_title="Old echo $1 | cut -d'_' -f 2-"
  fi

  if [ -n "${GIT_DIFFMERGE_VERBOSE-}" ]; then
    echo "Old: $1 -> absolute: $old_unix -> Windows: $old ($old_title)"
    echo "New: $2 -> absolute: $new_unix -> Windows: $new ($new_title)"
    echo
    echo "Command line:"
    set -x
  fi
}

# Sets global variables: base, local, remote, result
function get_merge_args()
{
  local path
  get_cygpath path

  base=$($path --mixed --absolute "$1")
  local base_unix=$($path --unix --absolute "$1")
  if [ ! -f "$base_unix" ]; then
    base=$($path --mixed --absolute ~/bin/git/tools/empty)
  fi

  local=$($path --mixed --absolute "$2")
  remote=$($path --mixed --absolute "$3")
  result=$($path --mixed --absolute "$4")

  if [ -n "${GIT_DIFFMERGE_VERBOSE-}" ]; then
    echo "Base: $1 -> absolute: $base_unix -> Windows: $base"
    echo "Local: $2 -> Windows: $local"
    echo "Remote: $3 -> Windows: $remote"
    echo "Result: $4 -> Windows: $result"
    echo
    echo "Command line:"
    set -x
  fi
}
