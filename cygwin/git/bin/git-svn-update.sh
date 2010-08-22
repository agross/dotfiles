#!/bin/sh

git pull origin master
rm -rf .git/svn
git svn rebase