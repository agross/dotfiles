# Set up completion for scripts in git/bin.
local -a user_commands
local user_command

# (*) = executable files.
for user_command in $HOME/.dotfiles/git/bin/git-*(*); do
  local name="$(basename "$user_command")"
  name="${name#git-}"
  name="${name%.*}"
  user_commands+=($name:"run $user_command")
done

zstyle ':completion:*:*:git:*' user-commands $user_commands
