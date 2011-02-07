#!/bin/sh

path="$(cygpath $1)"
old="$(cygpath --mixed --absolute "$1")"
oldUnixFormat="$(cygpath --unix --absolute "$1")"
new="$(cygpath --mixed --absolute "$2")"
newUnixFormat="$(cygpath --unix --absolute "$2")"
tool="$(cygpath --unix --absolute "C:/Tools/DiffMerge/diffmerge.exe")"

title1="Old"
title2="New $path"

if [ ! -f "$oldUnixFormat" ]
then
	old="$(cygpath --mixed --absolute ~/bin/git/diffmerge-empty)"
	title1="<File didn't exist>"
fi

if [ ! -f "$newUnixFormat" ]
then
	new="$(cygpath --mixed --absolute ~/bin/git/diffmerge-empty)"
	title1="Old $path"
	title2="<File has been deleted>"
fi

#echo -e "path\n$path"
#echo -e "old\n$old"
#echo -e "new\n$new"

"$tool" "$old" "$new" --title1="$title1" --title2="$title2"