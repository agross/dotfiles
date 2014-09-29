#!/bin/sh

set -e

svn_remote=$1
dir=$2
git svn clone $svn_remote $dir

cd $dir
git clean -df

git svn show-externals | \
  GREP_OPTIONS='' grep "^/" | \
  while read line;
  do
    # The path always starts with /, remove it using sed.
    dir=$(echo $line | cut -f 1 --delimiter=\  | sed 's/^.//')
    url=$(echo $line | cut -f 2 --delimiter=\ )

    echo -e "Path: $dir\n URL: $url"

    if [ -d "$dir" ]; then
      echo -e "$dir already exists\n"
      continue
    fi

    name=git-svn-external
    ref=refs/remotes/$name

    # Fetch the external into a separate subtree.
    git config svn-remote.$name.url $url
    git config svn-remote.$name.fetch :$ref
    git svn fetch $name

    # Merge the subtree into the svn:external folder.
    git merge --strategy=ours --no-ff --no-commit $ref
    git read-tree --prefix="$dir" -u $ref
    git commit --message="Merge svn:external $dir from $url"

    # Remove the svn:external subtree.
    git config --remove-section svn-remote.$name
    git branch --delete --remotes $name
    rm -r "$(git rev-parse --git-dir)/svn/$ref"
    git svn gc
  done
