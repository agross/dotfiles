(($+commands[ruby])) || return 0
[[ "$(platform)" == 'windows' ]] || return 0

# Make sure `ruby -e 'p Encoding.default_external'` is UTF-8.
chcp 65001 > /dev/null
