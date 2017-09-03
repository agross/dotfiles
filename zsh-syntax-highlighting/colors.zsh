typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[assign]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'

if [[ "$(echotc Co)" == '256' ]]; then
  ZSH_HIGHLIGHT_STYLES[assign]='fg=39' # Blue.
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=200' # Magenta.
fi
