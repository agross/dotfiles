# Get all styles with:
#
# print -l ${(ko)FAST_HIGHLIGHT_STYLES}
#
# and their color values with:
#
# Esc, X then enter fast-colors

zle -N fast-colors

FAST_HIGHLIGHT[use_brackets]=1

# Save compiled theme to temporary directory as I use different themes based
# on the iTerm profile.
FAST_WORK_DIR=$(mktemp --directory --suffix zsh-highlight-theme)

typeset -Ua overlays
overlays=(
  8/overlay.ini
  $(echotc Co)/overlay.ini
  $ITERM_PROFILE/overlay.ini
)

local overlay
for overlay in $overlays; do
  overlay=${0%/*}/colors/$overlay
  [[ -f $overlay ]] && fast-theme $overlay > /dev/null
done
