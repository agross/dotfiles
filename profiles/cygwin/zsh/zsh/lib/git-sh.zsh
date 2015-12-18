#
# A customized zsh environment suitable for git work.
#
# Copyright (C) 2008 Ryan Tomayko <http://tomayko.com/>
# Copyright (C) 2008 Aristotle Pagaltzis <http://plasmasturm.org/>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# Distributed under the GNU General Public License, version 2.0.

# Create aliases for most porcelain commands.
function porcelain_aliases() {
  local -aU verbs
  verbs=(
    'add'
    'am'
    'annotate'
    'apply'
    'archive'
    'bisect'
    'blame'
    'branch'
    'bundle'
    'cat-file'
    'checkout'
    'cherry'
    'cherry-pick'
    'clean'
    'clone'
    'commit'
    'config'
    'describe'
    'diff'
    'difftool'
    'fetch'
    'format-patch'
    'fsck'
    'gc'
    'gui'
    'hash-object'
    'init'
    'instaweb'
    'log'
    'lost-found'
    'ls-files'
    'ls-remote'
    'ls-tree'
    'merge'
    'merge-base'
    'mergetool'
    'name-rev'
    'patch-id'
    'peek-remote'
    'prune'
    'pull'
    'push'
    'quiltimport'
    'rebase'
    'reflog'
    'remote'
    'repack'
    'repo-config'
    'request-pull'
    'reset'
    'rev-list'
    'rev-parse'
    'revert'
    'send-email'
    'send-pack'
    'shortlog'
    'show'
    'show-branch'
    'stash'
    'status'
    'stripspace'
    'submodule'
    'svn'
    'symbolic-ref'
    'tag'
    'tar-tree'
    'var'
    'whatchanged'
  )

  local verb
  for verb in $verbs; do
    verbose Adding $fg[green]git porcelain$reset_color alias: $fg[red]$verb$reset_color = $fg[red]git $verb$reset_color
    alias $verb="git $verb"
  done
}

# Import aliases from .gitconfig.
function gitconfig_aliases() {
  # Split aliases based on NULL character.
  local -aU pairs
  pairs=("${(ps/\0/)$(git config --null --get-regexp 'alias\..*')}")

  local pair
  for pair in $pairs; do
    pair=("${(f)pair}")
    local alias=${pair[1]#alias.}
    local command=$pair[2]

    if [[ "$command[1]" == "!" ]]; then
      verbose Adding $fg[green].gitconfig$reset_color alias: $fg[red]$alias$reset_color = $fg[red]git $alias$reset_color

      # Commands starting with ! need to go through git.
      alias $alias="git $alias"
    else
      gitalias $alias="git $command"
    fi
  done
}

# gitalias <alias>='git <command> [<args>...]'
#
# Define a new shell alias (as with the alias builtin) named <alias>
# and enable command completion based on <command>. <command> must be
# a standard non-abbreviated git command name that has completion support.
#
# Examples:
#   gitalias c='git checkout'
#   gitalias ci='git commit -v'
#   gitalias r='git rebase --interactive HEAD~10'
function gitalias() {
  local alias="${1%%=*}"
  local command="${1#*=}"

  verbose Adding $fg[green]$funcstack[2]$reset_color alias: $fg[red]$alias$reset_color = $fg[red]$command$reset_color
  alias $alias="$command"
}

porcelain_aliases
#unfunction porcelain_aliases

gitconfig_aliases
unfunction gitconfig_aliases

# Source the system-wide rc file.
[ -r /etc/gitshrc ] && source /etc/gitshrc

# Source the user's rc file.
[ -r ~/.gitshrc ] && source ~/.gitshrc

unfunction gitalias
