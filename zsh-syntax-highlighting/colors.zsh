# Get all styles with:
# print -l ${(ko)FAST_HIGHLIGHT_STYLES}
typeset -gA FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[assign]='fg=blue,bold'
FAST_HIGHLIGHT_STYLES[commandseparator]='fg=magenta,bold'
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow,bold'
FAST_HIGHLIGHT_STYLES[globbing]='fg=cyan,bold'
FAST_HIGHLIGHT_STYLES[path]=underline
FAST_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
FAST_HIGHLIGHT_STYLES[redirection]='fg=magenta,bold'
FAST_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow,bold'
FAST_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
FAST_HIGHLIGHT_STYLES[variable]='fg=green,bold'

# Do we have 256 color support?
if [[ "$(echotc Co)" == '256' ]]; then
  FAST_HIGHLIGHT_STYLES[assign]='fg=39' # Blue.
  FAST_HIGHLIGHT_STYLES[reserved-word]='fg=200' # Magenta.
  FAST_HIGHLIGHT_STYLES[variable]='fg=112' # Green
fi
