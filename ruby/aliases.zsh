if ((! $+commands[ruby] && ! $+commands[rvm])); then
  return
fi

if [[ "$(platform)" == "windows" ]]; then
  verbose Setting up Windows Ruby aliases

  # Define an alias for *.bat file inside the Ruby bin directory.
  # Windows Ruby installs gem binaries as an extensionless file as well as one
  # with a .bat extension.
  # Glob qualifier (N.:r:t):
  #   N  = ignore no matches
  #   .  = yield plain files only
  #   :r = remove file extension
  #   :t = remove leading path (basename)
  local ruby_binary
  for ruby_binary in $(dirname "$commands[ruby]")/*.bat(N.:r:t); do
    alias "$ruby_binary"="$ruby_binary.bat"
  done

  alias bun='nocorrect bundle.bat'
  alias bex='nocorrect bundle.bat exec'
else
  verbose Setting up Linux Ruby aliases

  alias bun='bundle'
  alias bex='bundle exec'
fi
