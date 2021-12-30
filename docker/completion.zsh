# Use docker completion functions for commands in bin.
if (( $+functions[_docker] )); then
  compdef _docker dhealth=_docker_complete_containers

  if (( $+commands[dive] )); then
    compdef __docker_complete_repositories_with_tags dive
  fi
fi

# https://github.com/moby/moby/commit/402caa94d23ea3ad47f814fc1414a93c5c8e7e58
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
