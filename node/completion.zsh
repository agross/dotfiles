[[ "$OSTYPE" =~ ^(msys|cygwin)$ ]] || return 0

local prefix="$(cygpath --unix "$APPDATA/npm")"
local completion
for completion in $prefix/node_modules/*/completion/zsh(N); do
  eval "$(cat $completion)"
done

unset prefix completion
