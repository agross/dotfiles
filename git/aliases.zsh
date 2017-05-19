(($+commands[git])) || return 0

alias g=git
# Mnemonic: Git upstream.
# https://git-scm.com/docs/gitrevisions#gitrevisions-emltbranchnamegtupstreamemegemmasterupstreamememuem
alias -g GU='HEAD@{upstream}'
