#!/bin/sh

old="$(cygpath --mixed --absolute "$1")"
new="$(cygpath --mixed --absolute "$2")"

tool="$(cygpath --unix --absolute "C:/Tools/Meld/meld/meld.exe")"

#echo -e "old\n$old"
#echo -e "new\n$new"

"$tool" --diff "$old" "$new"
