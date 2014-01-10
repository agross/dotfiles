#!/bin/sh
#
# export GIT_DIFFMERGE_VERBOSE=1 to enable logging
#

script_path=${0%/*}
source "$script_path/diff-and-merge-support.sh"

get_tool_path difftool "C:/Tools/P4Merge/p4merge.exe"
get_diff_args "$1" "$2"

"$difftool" "$old" "$new"
