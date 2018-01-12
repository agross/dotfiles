# If unset, the cursor is set to the end of the word if completion is started.
# Otherwise it stays there and completion is done from both ends.
setopt complete_in_word

# Automatically list choices on an ambiguous completion.
setopt auto_list

# If a completion is performed with the cursor within a word, and a full
# completion is inserted, the cursor is moved to the end of the word. That is,
# the cursor is moved to the end of the word if either a single match is
# inserted or menu completion is performed.
setopt always_to_end

# If a parameter is completed whose content is the name of a directory, then add
# a trailing slash instead of a space.
unsetopt auto_param_slash

# Do not require a leading `.' in a filename to be matched explicitly.
setopt globdots

# In completion, recognize exact matches even if they are ambiguous.
setopt rec_exact

# On an ambiguous completion, instead of listing possibilities or beeping,
# insert the first match immediately.
setopt menu_complete

# A list of non-alphanumeric characters considered part of a word by the line
# editor.
WORDCHARS=''

# Enable colored completion.
zmodload -i zsh/complist

# Enable completion cache.
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh-completion

# Completion menu is always shown, show selection when >=3 entries.
zstyle ':completion:*' menu yes select=3

# The list of completers to use.
zstyle ':completion:*' completer _expand _complete _ignored _approximate

# Allow one error for every three characters typed in approximate completer.
zstyle -e ':completion:*:approximate:*' max-errors \
                                        'reply=($(( ($#PREFIX + $#SUFFIX) / 3 )) numeric)'

# Insert all expansions for expand completer.
zstyle ':completion:*:expand:*' tag-order all-expansions

# Formatting and messages.
zstyle ':completion:*'              verbose yes
zstyle ':completion:*:descriptions' format '%B• Completing %F{blue}%d%f%b'
zstyle ':completion:*:messages'     format '%d'
zstyle ':completion:*:warnings'     format '%B%F{red}No matches for%f%b: %d'
zstyle ':completion:*:corrections'  format \
                                    '%B• Completing %F{green}%d%f%b (%B%F{red}errors: %e%f%b)'
zstyle ':completion:*'              group-name ''
zstyle ':completion:*:-command-'    group-order builtins commands functions
zstyle ':completion:*'              list-prompt \
                                    '%B%K{blue}At %p (%l): Hit TAB for more, or the character to insert%k%b'
zstyle ':completion:*'              select-prompt \
                                    '%B%K{blue}At %p (%l): Hit TAB to complete, scrolling active%k%b'

# Complete in history with ESC, , and /
# http://zsh.sourceforge.net/Guide/zshguide06.html#l163
zstyle ':completion:history-words:*' list yes
zstyle ':completion:history-words:*' sort yes
zstyle ':completion:history-words:*' range 500
zstyle ':completion:history-words:*' remove-all-dups yes

# 1. Try case-sensitive completion.
# 2. Map German umlauts, allow case-insensitive completion.
# 3. Partial word completion.
# 4. Substring completion.
# http://stackoverflow.com/a/24237590/149264
# Way too slow on Windows.
if [[ "$(platform)" != 'windows' ]]; then
  zstyle ':completion:*' matcher-list '' \
                                      'm:ss=ß m:ue=ü m:ue=Ü m:oe=ö m:oe=Ö m:ae=ä m:ae=Ä m:{a-zA-Z}={A-Za-z}' \
                                      'r:|[._-]=* r:|=*' \
                                      'l:|=* r:|=*'
fi

# Ignore completion functions (until the _ignored completer).
zstyle ':completion:*:functions' ignored-patterns '_*'

# Ignore Windows executables as external commands.
zstyle ':completion:*:complete:-command-:*' ignored-patterns '*.(manifest|bat|dll|exe)'

# Ignore .DS_Store and .localized as files on macOS.
if [[ "$(platform)" == 'mac' ]]; then
  zstyle ':completion:*:*:*:*:*files' ignored-patterns '.DS_Store|.localized'
fi

# Attempt shell expansion on the current word up to cursor.
# Do not re-bind key if fzf completion has been loaded before.
if [[ $(bindkey '^I') != *fzf-completion ]]; then
  bindkey '^I'             expand-or-complete-prefix     # Tab
fi

# Perform history expansion and insert a space into the buffer. This is intended to be bound to SPACE.
bindkey ' '                magic-space

# Bound keys specific to menu selection.

# In a menu completion, insert the current completion into the buffer, and advance to the next possible completion.
#bindkey -M menuselect '^M' accept-and-menu-complete      # Return
# Execute the contents of the buffer. Then search the history list for a line matching the current one and push the event following onto the buffer stack.
# Fügt die Completion auf der Kommandozeile ein und zeigt dann ein Menü mit weiterhin möglichen Completions.
bindkey -M menuselect '^^' accept-and-infer-next-history # Ctrl + Return
# Undo last completion.
bindkey -M menuselect '^Z' undo                          # Ctrl + Z
# Abort completion.
bindkey -M menuselect '\e' send-break                    # ESC
bindkey -M menuselect '^C' send-break                    # Ctrl + C
# Leaves menu completion, accepting the current selection.
bindkey -M menuselect '^I' magic-space                   # Tab
bindkey -M menuselect ' '  magic-space

# Process completion.
zstyle ':completion:*:*:*:*:processes' command "ps --user \"$USER\""
# PID in red, rest default-colored.
zstyle ':completion:*:*:(wkill|kill):*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
