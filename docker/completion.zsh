local completion_dir='/Applications/Docker.app/Contents/Resources/etc'

[[ -d "$completion_dir" ]] || return 0

local function_dir="/usr/local/share/zsh/site-functions"
mkdir --parents "$function_dir"

local file
for file in $completion_dir/*.zsh-completion; do
  local target="$function_dir/_${file:r:t}"
  [[ "$file" == "${target:A}" ]] || ln --symbolic --force "$file" "$target"
done
