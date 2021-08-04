# The url-quote-magic line editing plugin automatically quotes metacharacters
# like question marks, quotes and ampersands while you type or paste them.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
