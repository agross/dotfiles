# Install iTerm shell integration if available.
#
# Update it using:
# curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

if [[ -f "$HOME/.iterm2_shell_integration.zsh" ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi
