[[ -d ~/.nodenv/bin ]] && path=(~/.nodenv/bin $path)

(($+commands[nodenv])) || return 0

eval "$(nodenv init - --no-rehash)"
