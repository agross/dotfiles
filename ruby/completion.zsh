# Use `bundle exec rake` to get available tasks.
zstyle ':completion:*:*:rake:*:targets' \
       command \
       '[[ -f Gemfile ]] && bex=(bundle exec); ${bex[@]} rake --silent --tasks'
