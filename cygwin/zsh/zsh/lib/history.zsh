# The file to save the history in when an interactive shell exits. If unset, the history is not saved. 
export HISTFILE=$HOME/.zsh_history

# The maximum number of events stored in the internal history list.
export HISTSIZE=1000

# The maximum number of history events to save in the history file. 
export SAVEHIST=1000

# If this is set, zsh sessions will append their history list to the history file, rather than replace it. Thus, multiple parallel zsh sessions will all have the new entries from their history lists added to the history file, in the order that they exit.
setopt append_history

# This options works like APPEND_HISTORY except that new history lines are added to the $HISTFILE incrementally (as soon as they are entered), rather than waiting until the shell exits.
setopt inc_append_history

# This option both imports new commands from the history file, and also causes your typed commands to be appended to the history file (the latter is like specifying INC_APPEND_HISTORY).
setopt share_history

# Save each command's beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.
setopt extended_history

# Do not enter command lines into the history list if they are duplicates of the previous event. 
setopt hist_ignore_dups

# If the internal history needs to be trimmed to add the current command line, setting this option will cause the oldest history event that has a duplicate to be lost before losing a unique event from the list. You should be sure to set the value of HISTSIZE to a larger number than SAVEHIST in order to give you some room for the duplicated events, otherwise this option will behave just like HIST_IGNORE_ALL_DUPS once the history fills up with unique events.
setopt hist_expire_dups_first

# Whenever the user enters a line with history expansion, don't execute the line directly; instead, perform history expansion and reload the line into the editing buffer. 
setopt hist_verify

# Remove superfluous blanks from each command line being added to the history list. 
setopt hist_reduce_blanks