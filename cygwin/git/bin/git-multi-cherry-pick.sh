#!/bin/sh

if [ -z $1 ]; then
    echo "Equivalent to running git-cherry-pick on each of the commits in the range specified.";
    echo "";
    echo "Usage:  $0 start^..end";
    echo "";
    exit 1;
fi

git rev-list --reverse --topo-order $1 | while read rev 
do 
  git cherry-pick $rev || break 
done
