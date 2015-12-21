#!/bin/bash

# Merges develop into feature/* and pushes if the merge is successful.

green='\e[1;32m'
yellow='\e[1;33m'
red='\e[1;31m'
no_color='\e[0m'

# Switch back to the branch we're currently on when the script exits.
current_branch=`git rev-parse --abbrev-ref HEAD`
trap 'git checkout $current_branch 2> /dev/null' EXIT

features=`git branch --no-color --list feature/* | cut -c 3-`
failed_merges=()
for feature in $features; do
  echo -e "${yellow}Feature: $feature${no_color}"

  git checkout $feature 2> /dev/null
  git merge develop > /dev/null

  if [ $? -ne 0 ]; then
    failed_merges+=($feature)
    echo -e "${red}Merge unsuccessful: $feature${no_color}"

    git merge --abort
    git clean -f
  else
    echo -e "${green}Merge successful, going to push"
    git push 2> /dev/null
  fi
done

echo
if [ ${#failed_merges[@]} -eq 0 ]; then
  echo -e "${green}No failed merges${no_color}"
else
  echo -e "${red}Failed merges:${no_color}"
  printf -- ' - %s\n' "${failed_merges[@]}"
fi
