#!/bin/sh

local="$(cygpath --mixed --absolute "$2")"
base="$(cygpath --mixed --absolute "$1")"
baseUnixFormat="$(cygpath --unix --absolute "$1")"
remote="$(cygpath --mixed --absolute "$3")"
result="$(cygpath --mixed --absolute "$4")"
tool="$(cygpath --unix --absolute "C:/Users/agross/AppData/Local/PlasticSCM4/semanticmerge/semanticmergetool.exe")"

if [ ! -f "$baseUnixFormat" ]
then
	base="$(cygpath --mixed --absolute ~/bin/git/tools/empty)"
fi

#echo -e "local\n$local"
#echo -e "base\n$base"
#echo -e "remote\n$remote"
#echo -e "result\n$result"

"$tool" -b="$base" -d="$local" -s="$remote" -r="$result" -l=csharp -emt="mergetool.exe -b=\"@basefile\" -bn=\"@basesymbolic\" -s=\"@sourcefile\" -sn=\"@sourcesymbolic\" -d=\"@destinationfile\" -dn=\"@destinationsymbolic\" -r=\"@output\" -t=\"@filetype\" -i=\"@comparationmethod\" -e=\"@fileencoding\" -edt=\"mergetool.exe -s=\"@sourcefile\" -sn=\"@sourcesymbolic\" -d=\"@destinationfile\" -dn=\"@destinationsymbolic\" -t=\"@filetype\" -i=\"@comparationmethod\" -e=\"@fileencoding\""
