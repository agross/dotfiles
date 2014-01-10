#!/bin/sh
#
# export GIT_DIFFMERGE_VERBOSE=1 to enable logging
#

script_path=${0%/*}
source "$script_path/diff-and-merge-support.sh"

get_tool_path mergetool "C:/Tools/DiffMerge/diffmerge.exe"
get_merge_args "$1" "$2" "$3" "$4"

"$mergetool" --merge --result="$result" "$local" "$base" "$remote" --title1="Mine" --title2="Merged: $4" --title3="Theirs"
