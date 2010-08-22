#!/bin/sh

local="$(cygpath --mixed --absolute "$2")"
base="$(cygpath --mixed --absolute "$1")"
baseUnixFormat="$(cygpath --unix --absolute "$1")"
remote="$(cygpath --mixed --absolute "$3")"
result="$(cygpath --mixed --absolute "$4")"
tool="$(cygpath --unix --absolute "C:/Tools/DiffMerge/diffmerge.exe")"

if [ ! -f "$baseUnixFormat" ]
then
	base="$(cygpath --mixed --absolute ~/bin/diffmerge-empty)"
fi

#echo -e "local\n$local"
#echo -e "base\n$base"
#echo -e "remote\n$remote"
#echo -e "result\n$result"

"$tool" --merge --result="$result" "$local" "$base" "$remote" --title1="Mine" --title2="Merged: $4" --title3="Theirs"