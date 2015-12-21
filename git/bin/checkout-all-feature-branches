#!/bin/bash

# Creates local branches for all remote branches matching origin/feature/*.

green='\e[1;32m'
no_color='\e[0m'

features=`git branch --no-color --remotes --list origin/feature/* | cut -c 3-`
for feature in $features; do
  echo -e "${green}Feature: $feature${no_color}"

  git branch ${feature#origin/} --track $feature
done

# Equivalent one-liner for your shell:
# git branch --no-color --remotes --list origin/feature/* | cut -c 3- | xargs -n 1 sh -c 'git branch ${1#origin/} --track $1' argv0
