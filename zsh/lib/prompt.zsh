# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status.
setopt prompt_subst

# Do not attempt to preserve a partial line (i.e. a line that did not end with a newline) that would otherwise be covered up by the command prompt due to the PROMPT_CR option.
unsetopt PROMPT_SP

# Load the prompt theme system.
autoload -U promptinit
promptinit
