#!/bin/bash

git log --format=%n --name-only | env GREP_OPTIONS='' grep -v '^$' | sort | uniq --count | sort --numeric-sort --reverse | head --lines=50
