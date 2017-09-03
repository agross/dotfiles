# Support # comments in command lines.
setopt interactivecomments

# If set, parameter expansion, command substitution and arithmetic expansion are
# performed in prompts. Substitutions within prompts do not affect the command
# status.
setopt prompt_subst

# Print a carriage return just before printing a prompt in the line editor.
setopt PROMPT_CR

# Attempt to preserve a partial line (i.e. a line that did not end with a
# newline) that would otherwise be covered up by the command prompt due to the
# PROMPT_CR option. Typically caused by null-terminating characters, e.g. find
# /tmp -print0
setopt PROMPT_SP

# Load the prompt theme system.
autoload -U promptinit
promptinit
