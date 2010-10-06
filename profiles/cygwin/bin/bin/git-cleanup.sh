#!/bin/sh

git reflog expire --expire=1.minute --all
git fsck --unreachable
git prune
git gc