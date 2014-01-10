#!/bin/sh

function commit()
{
  mkdir -p "$(dirname "$2")"

  echo $1 > "$2"
  git add "$2"
  git commit -m "$1"
}

file_name="some path/conflicted file"

git init

commit "dummy" "dummy"

git checkout -b another_branch
commit "bar" "$file_name"

git checkout master
commit "baz" "$file_name"

git merge another_branch
