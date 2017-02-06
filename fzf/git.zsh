(($+commands[fzf])) || (($+commands[fzf-tmux])) || return 0

function _fzf::git::is_repo() {
  git rev-parse --git-dir > /dev/null 2>&1
}

function _fzf::git::diff-so-fancy() {
  if (($+commands[diff-so-fancy])); then
    printf '| diff-so-fancy'
  fi
}

function _fzf::git::file() {
  _fzf::git::is_repo || return

  # Preview doesn't work perfectly with renames, but cat works with files with spaces.
  git -c color.status=always \
      status \
      --short |
    fzf-tmux --ansi \
             --multi \
             --cycle \
             --nth 2..,.. \
             --preview "(git ls-files --error-unmatch -- {2..} > /dev/null 2>&1 &&
                         git diff --color=always -- {2..} $(_fzf::git::diff-so-fancy)) ||
                         cat {2..}" |
    cut -c 4- |
    sed 's/.* -> //'
}

function _fzf::git::branch() {
  _fzf::git::is_repo || return

  git branch --all \
             --color=always |
    command grep --invert-match '(HEAD detached at' |
    fzf-tmux --ansi \
             --multi \
             --cycle \
             --tac \
             --preview-window=right:70% \
             --preview 'git log --graph \
                                --color=always \
                                --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" \
                                $(sed s/^..// <<< {} | cut --delimiter=" " --fields=1) --' |
    sed 's/^..//' |
    cut --delimiter=' ' --fields=1
}

function _fzf::git::tag() {
  _fzf::git::is_repo || return

  git tag --sort=-version:refname |
    fzf-tmux --multi \
             --cycle \
             --preview-window=right:70% \
             --preview "git show --color=always {} $(_fzf::git::diff-so-fancy)"
}

function _fzf::git::remote() {
  _fzf::git::is_repo || return

  git remote --verbose |
    awk '{print $1 "\t" $2}' |
    uniq |
    fzf-tmux --cycle \
             --sort \
             --tac |
    cut --delimiter=$'\t' --fields=1
}

function _fzf::git::hash() {
  _fzf::git::is_repo || return

  local extract_sha inspect preview
  extract_sha="command grep --only-matching '[a-f0-9]\{7,\}' <<< {} | head --lines=1"
  inspect="$extract_sha | \
           xargs --no-run-if-empty -I % sh -c 'GIT_PAGER_ARGS= git show %'"
  preview="$extract_sha | \
           xargs --no-run-if-empty git show --color=always \
           $(_fzf::git::diff-so-fancy)"

  git log --graph \
          --all \
          --branches \
          --color=always \
          --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' |
    fzf-tmux --ansi \
             --height=99% \
             --no-sort \
             --reverse \
             --cycle \
             --tiebreak=index \
             --multi \
             --preview "$preview" \
             | # Does not work when called from zle widget: --bind "ctrl-space:execute($inspect)" |
    command grep --only-matching '[a-f0-9]\{7,\}'
}

function _fzf::join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

function _fzf::git::bind-keys() {
  typeset -A bindings
  bindings=("${(Q@)${(z)1}}")

  for key fun in ${(kv)bindings}; do
    eval "
      function fzf-git-$fun-widget() {
        local result=\"\$(_fzf::git::$fun | _fzf::join-lines)\"
        zle reset-prompt
        LBUFFER+=\"\$result\"
      }
    "

    zle -N "fzf-git-$fun-widget"
    bindkey "^g^$key" "fzf-git-$fun-widget"
  done

  unfunction $0
}

# These will be defined as key bindings: ^g^<key> for _fzf::git::<value>
local -A bindings
bindings[f]=file
bindings[b]=branch
bindings[t]=tag
bindings[r]=remote
bindings[h]=hash

_fzf::git::bind-keys "${${(@qqkv)bindings}[*]}"
