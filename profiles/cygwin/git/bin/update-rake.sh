#!/bin/sh

git submodule update
cd "$PWD/tools/Rake"
git pull origin master
cd "$PWD/../.."
git add tools/Rake