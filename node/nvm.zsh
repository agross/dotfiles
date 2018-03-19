[[ -f /usr/local/opt/nvm/nvm.sh ]] || return 0

export NVM_DIR="$HOME/.nvm"
[[ ! -d "$NVM_DIR" ]] && mkdir "$NVM_DIR"

source "/usr/local/opt/nvm/nvm.sh"
