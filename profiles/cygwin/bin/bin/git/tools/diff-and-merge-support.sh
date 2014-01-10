#!/bin/sh
#
# export GIT_DIFFMERGE_VERBOSE=1 to enable logging
#

function get_cygpath()
{
  local __result=$1
  local cygpath=$(command -v cygpath)

  if [ "x$cygpath" = "x" ]; then
    # Assume a local copy of cygpath.exe and cygwin1.dll (e.g. for MSysGit)
    local script_path=${0%/*}
    cygpath=$script_path/cygpath
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

  old=$($path --mixed "$1")
  # Extract file name from git's temporary file: /tmp/<garbage>_filename
  old_title="Old $(echo $1 | cut -d'_' -f 2-)"
  if [ ! -f "$1" ]; then
    old=$($path --mixed ~/bin/git/tools/empty)
    old_title="<File didn't exist>"
  fi

  new=$($path --mixed "$2")
  new_title="New $2"
  if [ ! -f "$2" ]; then
    new=$($path --mixed ~/bin/git/tools/empty)
    new_title="<File has been deleted>"
  fi

  if [ ! -f "$2" ]; then
    # Extract file name from git's temporary file: /tmp/<garbage>_filename
    old_title="Old $(echo $1 | cut -d'_' -f 2-)"
  fi

  if [ -n "${GIT_DIFFMERGE_VERBOSE-}" ]; then
    echo "Old: $1 -> Windows: $old ($old_title)"
    echo "New: $2 -> Windows: $new ($new_title)"
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

  base=$($path --mixed "$1")
  if [ ! -f "$1" ]; then
    base=$($path --mixed ~/bin/git/tools/empty)
  fi

  local=$($path --mixed "$2")
  remote=$($path --mixed "$3")
  result=$($path --mixed "$4")

  if [ -n "${GIT_DIFFMERGE_VERBOSE-}" ]; then
    echo "Base: $1 -> Windows: $base"
    echo "Local: $2 -> Windows: $local"
    echo "Remote: $3 -> Windows: $remote"
    echo "Result: $4 -> Windows: $result"
    echo
    echo "Command line:"
    set -x
  fi
}
