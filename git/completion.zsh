# Remove the crappy zsh completion shipped by Homebrew git.
# I prefer zsh's builtin git completion.
# https://github.com/Homebrew/homebrew-core/issues/33275
if (($+commands[brew])); then
  [[ -f $(brew --prefix)/share/zsh/site-functions/_git ]] && \
    rm -f $(brew --prefix)/share/zsh/site-functions/_git
fi

# Set up completion for git-* scripts.
local -a user_commands
local user_command

for user_command in ${commands[(I)git-*]}; do
  # If there is a completion function it likely has a #description in the second
  # line and is picked up automatically.
  (( $+functions[_$user_command] )) && continue

  name="${user_command#git-}"
  name="${name%.*}"
  user_commands+=($name:"run $commands[$user_command]")
done

zstyle ':completion:*:*:git:*' user-commands $user_commands
