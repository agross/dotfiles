#!/bin/sh
#
# export GIT_DIFFMERGE_VERBOSE=1 to enable logging
#

script_path=${0%/*}
source "$script_path/diff-and-merge-support.sh"

get_tool_path mergetool "C:/Users/agross/AppData/Local/PlasticSCM4/semanticmerge/semanticmergetool.exe"
get_merge_args "$1" "$2" "$3" "$4"

"$mergetool" -b="$base" -d="$local" -s="$remote" -r="$result" -l=csharp -emt="mergetool.exe -b=\"@basefile\" -bn=\"@basesymbolic\" -s=\"@sourcefile\" -sn=\"@sourcesymbolic\" -d=\"@destinationfile\" -dn=\"@destinationsymbolic\" -r=\"@output\" -t=\"@filetype\" -i=\"@comparationmethod\" -e=\"@fileencoding\" -edt=\"mergetool.exe -s=\"@sourcefile\" -sn=\"@sourcesymbolic\" -d=\"@destinationfile\" -dn=\"@destinationsymbolic\" -t=\"@filetype\" -i=\"@comparationmethod\" -e=\"@fileencoding\""
