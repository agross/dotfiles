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

commit "unrelated file" "unrelated file"

git checkout -b another_branch
commit "their line" "$file_name"

git checkout master
commit "our line" "$file_name"

git merge another_branch
