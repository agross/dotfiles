# Deletes all bindings.
# bindkey -d
# List keymaps.
# bindkey -l
# List key bindings with as you would set up them using bindkey (the command).
# bindkey -L
# List bindings in keymap menuselect.
# bindkey -M menuselect
# About widgets: http://sgeb.io/articles/zsh-zle-closer-look-custom-widgets/

# To obtain key codes type Ctrl+X, followed by the key combination.
# The code is then printed to the console.
bindkey '^X'      quoted-insert        # Ctrl + X

bindkey '\eb'     kill-region          # ESC, b
bindkey '^E'      kill-whole-line      # Ctrl + E

bindkey '^C'      send-break           # Ctrl + C
bindkey '^Z'      undo                 # Ctrl + Z
bindkey '^Y'      redo                 # Ctrl + Y

bindkey '^R'      history-incremental-pattern-search-backward # Ctrl + R
bindkey '^F'      history-incremental-pattern-search-forward  # Ctrl + F (below R)

bindkey '^[[A'    up-line-or-history   # Up arrow
bindkey '^[[B'    down-line-or-history # Down arrow

# Make search up and down work, so partially type and hit Shift + up/down to find relevant stuff.
bindkey '\e[1;2A' up-line-or-search    # Shift + Up arrow
bindkey '\e[1;2B' down-line-or-search  # Shift + Down arrow

# Bring up a menu of history commands starting with what was entered.
autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu-end history-beginning-search-menu
bindkey '^X^X' history-beginning-search-menu-end

zmodload -i zsh/terminfo
[[ -n "$terminfo[khome]" ]] && bindkey $terminfo[khome] beginning-of-line # Home
bindkey '^[[1~'   beginning-of-line                                       # Home, Cmd + left arrow
[[ -n "$terminfo[kend]" ]]  && bindkey $terminfo[kend]  end-of-line       # End
bindkey '^[[4~'   end-of-line                                             # End, Cmd + right arrow
[[ -n "$terminfo[kdch1]" ]] && bindkey $terminfo[kdch1] delete-char       # Del

bindkey '^[[1;5D' backward-word        # Ctrl + left arrow, Option + left arrow
bindkey '^[[1;5C' forward-word         # Ctrl + right arrow, Option + right arrow
bindkey '^_'      backward-delete-word # Ctrl + Backspace
bindkey '^[[3;5~' delete-word          # Ctrl + Del
bindkey '^[[3;2~' delete-word          # Shift + Del
# I can type multiline command lines, and still be able to move the cursor up/down between the lines while editing.
# bindkey '^J'      self-insert          # Ctrl + J, Home and End for moving to the beginning and end.

bindkey '^D'      copy-prev-shell-word # Ctrl + D

zle -N paste-from-clipboard
bindkey '^V'      paste-from-clipboard # Ctrl + V

bindkey '\e.'     insert-last-word     # ESC, .
# Copy the word before the one just copied by insert-last-word.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey '\em'     copy-earlier-word    # ESC, m

zle -N insert-last-command-output
bindkey '\e1'     insert-last-command-output # ESC, 1

# Transpose arguments using ESC, t using shell rules.
autoload -Uz transpose-words-match
zstyle ':zle:transpose-words' word-style shell
zle -N transpose-words transpose-words-match

# Edit the command line with Ctrl + X, Ctrl +E or Esc, e.
# In addition, you may use `fc` to fix the last command executed.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey '\ee' edit-command-line
