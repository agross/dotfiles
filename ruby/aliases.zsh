if ((! $+commands[ruby] && ! $+commands[rvm])); then
  return
fi

if [[ "$(platform)" == "windows" ]]; then
  verbose Setting up Windows Ruby aliases

  alias gem='gem.bat'
  alias rake='rake.bat'
  alias irb='irb.bat'
  # bundle conflicts with the git-bundle auto-alias, so define a second alias.
  alias bundle='bundle.bat'
  alias bun='nocorrect bundle.bat'
  alias bex='nocorrect bundle.bat exec'
else
  verbose Setting up Linux Ruby aliases

  alias bun='bundle'
  alias bex='bundle exec'
fi
