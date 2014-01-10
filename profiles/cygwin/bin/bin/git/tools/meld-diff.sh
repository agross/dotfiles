#!/bin/sh
#
# export GIT_DIFFMERGE_VERBOSE=1 to enable logging
#

script_path=${0%/*}
source "$script_path/diff-and-merge-support.sh"

get_cygpath path
old=$($path --mixed --absolute "$1")
new=$($path --mixed --absolute "$2")

get_tool_path difftool "C:/Tools/Meld/meld/meld.exe"

"$difftool" --diff "$old" "$new"
