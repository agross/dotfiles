(($+commands[ruby])) || return 0
[[ "$OSTYPE" =~ ^(msys|cygwin)$ ]] || return 0

# Make sure `ruby -e 'p Encoding.default_external'` is UTF-8.
chcp 65001 > /dev/null
