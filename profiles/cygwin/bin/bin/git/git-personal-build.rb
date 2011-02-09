#!/usr/bin/env ruby

## git-personal-build:
## Pushes a branch to a remote such that TeamCity 6.5. can 
## pick up the changes and start a personal build for build configurations
## that are configured with a Branch Remote Run Trigger.
##
## More information: http://confluence.jetbrains.net/display/TCD6/Branch+Remote+Run+Trigger
##
## Usage: git personal-build <user> [branch] [repository]
##
## <user> is the TeamCity user name, [branch] is the branch to publish
## (defaults to the current branch), and [repository] defaults to "origin".
## The remote branch name will be refs/remote-run/<user>/<branch>

user = ARGV.shift
head = `git symbolic-ref HEAD`.chomp.gsub(/refs\/heads\//, "")
branch = (ARGV.shift || head).gsub(/refs\/heads\//, "")
local_ref = `git show-ref heads/#{branch}`
remote = ARGV.shift || "origin"

abort "No local branch #{branch} exists!" if local_ref.empty?

system "git push origin +#{branch}:refs/remote-run/#{user}/#{branch}"