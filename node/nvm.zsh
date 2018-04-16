local -a nvm
nvm=(/usr/local/opt/nvm/nvm.sh $HOME/.nvm/nvm.sh)

local candidate match
for candidate in $nvm; do
  [[ -f $candidate ]] && match=$candidate && break
done

[[ -n $match ]] || return 0

export NVM_DIR="$HOME/.nvm"
[[ ! -d "$NVM_DIR" ]] && mkdir "$NVM_DIR"

source "$match"
