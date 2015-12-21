#!/bin/sh

if [ $# -lt 1 ]
then
	echo "Find files touched by branch of current HEAD, compared to another branch"
	echo ""
	echo "USAGE: $0 [-g] <other-branch>"
	echo ""
	echo "       -g  Group by directory"
	echo ""
	echo "EXAMPLE: $0 master"
	exit 1
fi

reference=$1
if [ $# -eq 2 ]
then
  reference=$2
fi

files=`git diff --name-only $reference...head`

if [ $# -eq 1 ]
then
  echo "$files" | uniq | sort
else
  echo "$files" | xargs --max-lines=1 dirname | uniq | sort
fi
