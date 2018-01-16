# The file to save the history in when an interactive shell exits. If unset, the
# history is not saved.
HISTFILE=$HOME/.zsh_history

# The maximum number of events stored in the internal history list.
HISTSIZE=5000

# The maximum number of history events to save in the history file.
SAVEHIST=5000

# This option is a variant of INC_APPEND_HISTORY in which, where possible, the
# history entry is written out to the file after the command is finished, so
# that the time taken by the command is recorded correctly in the history file
# in EXTENDED_HISTORY format. This means that the history entry will not be
# available immediately from other instances of the shell that are using the
# same history file.
setopt inc_append_history_time

# This option is a variant of INC_APPEND_HISTORY in which, where possible, the
# history entry is written out to the file after the command is finished, so
# that the time taken by the command is recorded correctly in the history file
# in EXTENDED_HISTORY format.
setopt share_history

# Save each command's beginning timestamp (in seconds since the epoch) and the
# duration (in seconds) to the history file.
setopt extended_history

# Do not enter command lines into the history list if they are duplicates of the
# previous event.
setopt hist_ignore_dups

# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous
# event).
setopt hist_ignore_all_dups

# Whenever the user enters a line with history expansion, don't execute the line
# directly; instead, perform history expansion and reload the line into the
# editing buffer.
setopt hist_verify

# Remove superfluous blanks from each command line being added to the history
# list.
setopt hist_reduce_blanks

# By default, shell history that is read in from files is split into words on
# all white space. This means that arguments with quoted whitespace are not
# correctly handled, with the consequence that references to words in history
# lines that have been read from a file may be inaccurate. When this option is
# set, words read in from a history file are divided up in a similar fashion to
# normal shell command line handling.
setopt hist_lex_words
