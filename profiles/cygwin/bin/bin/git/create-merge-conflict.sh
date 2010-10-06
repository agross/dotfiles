#!/bin/sh

function commit()
{
	echo $1 > $2
	git add $2
	git commit -m $1
}

git init

commit "foo" file
git checkout -b another_branch

commit "bar" file
git checkout master

commit "baz" file
git merge another_branch