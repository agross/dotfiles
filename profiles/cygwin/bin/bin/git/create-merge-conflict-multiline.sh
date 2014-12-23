#!/bin/sh

function commit()
{
  mkdir -p "$(dirname "$2")"

  echo -e $1 > "$2"
  git add "$2"
  git commit -m "$1"
}

file_name="some path/conflicted file"

git init

commit "first line\n\nline from base commit\n\nlast line" "$file_name"

git checkout -b another_branch
commit "first line changed by them\nand added another line\n\ntheir line\n\nlast line" "$file_name"

git checkout master
commit "first line\n\nour line\n\nlast line changed by us\nand added another line" "$file_name"

git merge another_branch
