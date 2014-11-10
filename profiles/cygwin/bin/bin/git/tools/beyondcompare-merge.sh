#!/bin/sh
#
# export GIT_DIFFMERGE_VERBOSE=1 to enable logging
#

script_path=${0%/*}
source "$script_path/diff-and-merge-support.sh"

mergetool="/c/Tools/Beyond Compare/BCompare.exe"
get_merge_args "$1" "$2" "$3" "$4"

"$mergetool" /solo /automerge "$local" "$remote" "$base" "$result" /title1="Mine" /title2="Base" /title3="Theirs" /title4="Merged: $4"
