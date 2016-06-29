if ((! $+commands[ruby] && ! $+commands[rvm])); then
  return
fi

if [[ "$(platform)" == "windows" ]]; then
  verbose Setting up Windows Ruby aliases

  # Define an alias for *.bat and *.cmd files inside the Ruby bin directory.
  # Windows Ruby installs gem binaries as an extensionless file as well as one
  # with a .bat extension. *.cmd is used for e.g. gem.cmd by Ruby Installer.
  # Glob qualifier (N.:r:t):
  #   N  = ignore no matches
  #   .  = yield plain files only
  #   :t = remove leading path (basename)
  local ruby_binary
  for ruby_binary in $(dirname "$commands[ruby]")/*.{bat,cmd}(N.:t); do
    local filename="${ruby_binary%.*}"
    alias "$filename"="$ruby_binary"
  done

  alias bun='nocorrect bundle.bat'
  alias bex='nocorrect bundle.bat exec'
else
  verbose Setting up Linux Ruby aliases

  alias bun='nocorrect bundle'
  alias bex='nocorrect bundle exec'
fi
