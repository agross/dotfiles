[[ -d ~/.rbenv/bin ]] && path=(~/.rbenv/bin $path)

(($+commands[rbenv])) || return 0

eval "$(rbenv init -)"
