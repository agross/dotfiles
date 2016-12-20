# Glob qualifiers:
#  .  = plain files only
#  on = sort files by name

local f
for f in ${0%/*}/**/*.zsh(.on); do
  [[ "$f" == "$0" ]] && continue

  verbose Sourcing $fg[green]$f$reset_color
  source "$f"
done
