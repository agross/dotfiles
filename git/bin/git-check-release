#!/bin/sh

for branch in "$@"
  do
    echo Checking $branch

    found_branches=`git branch -r | grep $branch | wc -l | tr -d ' '`
    if [ "$found_branches" -ne "1" ]
    then
      echo -e "\033[1;33m -> $found_branches matching remote branches found\033[0m"

      if [ "$found_branches" -ne "0" ]
      then
        git branch -r | grep $branch
      fi

      continue
    fi

    on_master=`git branch -r | grep $branch | xargs git branch --contains | grep master`

    if [ -n "$on_master" ]
    then
      echo -e "\033[32m -> on master\033[0m"
    else echo -e "\033[1;31m -> NOT on master\033[0m"
    fi
    done
