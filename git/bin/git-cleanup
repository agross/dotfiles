#!/bin/sh

git reflog expire --expire=now --all
git fsck --unreachable
git prune
git gc --prune=now
