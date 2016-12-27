autoload -U colors && colors

# Debug with:
# LESS_TERMCAP_DEBUG=1 man git

export LESS_TERMCAP_mb=$fg_bold[red]                   # begin blinking
# E.g. sections, code, keywords.
export LESS_TERMCAP_md=$fg[yellow]                     # begin bold
export LESS_TERMCAP_me=$reset_color                    # end mode
# Pager.
export LESS_TERMCAP_so=$bg_bold[blue]$fg_bold[white]   # begin standout-mode
export LESS_TERMCAP_se=$reset_color                    # end standout-mode
# E.g. commands.
export LESS_TERMCAP_us=$fg_bold[green]                 # begin underline
export LESS_TERMCAP_ue=$reset_color                    # end underline

# This is required for Linux.
# https://lists.fedoraproject.org/pipermail/users/2014-July/452172.html
export GROFF_NO_SGR=yes
