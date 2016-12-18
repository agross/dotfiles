[[ "$(platform)" == 'windows' ]] || return 0

# Drives that cannot be reached by globbing.
local drives=($(mount | /bin/grep --perl-regexp '^\w: on /\w ' | cut --delimiter=' ' --fields=3))
zstyle ':completion:*' fake-files "/:${(j. .)drives//\//}"

# Use kill completion for wkill.
compdef wkill=kill
zstyle ':completion:*:*:wkill:*:processes' command "ps --user "$USER" --windows"
