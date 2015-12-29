# How to obtain key codes in zsh:
# bindkey -d # deletes all bindings
# Ctrl+X, followed by the key combination desired to bind prints the code to the console.
bindkey '^X'      quoted-insert        # Ctrl + X

bindkey '\eb'     kill-region          # ESC, b
bindkey '\e\e'    kill-buffer          # ESC, ESC
bindkey '^E'      kill-whole-line      # Ctrl + E

bindkey '^[^[[A'  beep                 # ESC, Up arrow
bindkey '^[^[[B'  beep                 # ESC, Down arrow
bindkey '^[^[[C'  beep                 # ESC, Right arrow
bindkey '^[^[[D'  beep                 # ESC, Left arrow

bindkey '^Z'      undo                 # Ctrl + Z
bindkey '^Y'      redo                 # Ctrl + Y

bindkey '^R'      history-incremental-pattern-search-backward # Ctrl + R
bindkey '^H'      history-incremental-pattern-search-backward # Ctrl + H
bindkey '^J'      history-incremental-pattern-search-forward  # Ctrl + J

bindkey '^[[5~'   up-line-or-history   # Shift + up arrow
bindkey '^[[6~'   down-line-or-history # Shift + down arrow
bindkey '^[[A'    up-line-or-history   # Up arrow
bindkey '^[[B'    down-line-or-history # Down arrow

# Make search up and down work, so partially type and hit Ctrl + up/down to find relevant stuff.
bindkey '^[[1;5A' up-line-or-search    # Ctrl + Up arrow
bindkey '^[[1;5B' down-line-or-search  # Ctrl + Down arrow

bindkey '^[[H'    beginning-of-line    # Home
bindkey '^[[1~'   beginning-of-line    # Home in ConEmu
bindkey '^[[F'    end-of-line          # End
bindkey '^[[4~'   end-of-line          # End in ConEmu
bindkey '^[[1;5D' backward-word        # Ctrl + left arrow
bindkey '^[[1;5C' forward-word         # Ctrl + right arrow
bindkey '^[[3~'   delete-char          # Del
bindkey '^_'      backward-delete-word # Ctrl + Backspace
bindkey '^[[3;5~' delete-word          # Ctrl + Del
bindkey '^[[3;2~' delete-word          # Shift + Del

# I can type multiline command lines, and still be able to move the cursor up/down between the lines while editing.
# bindkey '^J'      self-insert          # Ctrl + J, Home and End for moving to the beginning and end.

bindkey '^D'      copy-prev-shell-word # Ctrl + D

autoload -Uz paste-from-clipboard
zle -N paste-from-clipboard
bindkey '^V'      paste-from-clipboard # Ctrl + V

bindkey '^[.'     insert-last-word     # ESC, .
# Copy the word before the one just copied by insert-last-word.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey '^[m'     copy-earlier-word    # ESC, m

zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey '^[1'     insert-last-command-output # ESC, 1
