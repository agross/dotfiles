# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status. 
setopt prompt_subst

# Load the prompt theme system.
autoload -U promptinit
promptinit