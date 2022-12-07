case "$OSTYPE" in
  linux*)
    local completion_dir='/usr/share/zsh/vendor-completions'

    [[ -d "$completion_dir" ]] || return 0

    fpath=($completion_dir $fpath)
    ;;

  darwin*)
    # Seems like nowadays docker installs its completion itself. Keep regardless.
    local completion_dir='/Applications/Docker.app/Contents/Resources/etc'

    [[ -d "$completion_dir" ]] || return 0

    local function_dir="$(brew --prefix)/share/zsh/site-functions"
    mkdir --parents "$function_dir"

    local file=
    for file in $completion_dir/*.zsh-completion; do
      local target="$function_dir/_${file:r:t}"
      [[ "$file" == "${target:A}" ]] || ln --symbolic --force "$file" "$target"
    done
    ;;

  *)
    return 0
    ;;
esac
