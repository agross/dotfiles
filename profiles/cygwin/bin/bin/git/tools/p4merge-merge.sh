#!/bin/sh

local="$(cygpath --mixed --absolute "$2")"
base="$(cygpath --mixed --absolute "$1")"
baseUnixFormat="$(cygpath --unix --absolute "$1")"
remote="$(cygpath --mixed --absolute "$3")"
result="$(cygpath --mixed --absolute "$4")"
tool="$(cygpath --unix --absolute "C:/Tools/P4Merge/p4merge.exe")"

if [ ! -f "$baseUnixFormat" ]
then
	base="$(cygpath --mixed --absolute ~/bin/git/tools/empty)"
fi

#echo -e "local\n$local"
#echo -e "base\n$base"
#echo -e "remote\n$remote"
#echo -e "result\n$result"

"$tool" "$base" "$local" "$remote" "$result"
