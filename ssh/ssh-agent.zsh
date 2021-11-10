# shellcheck disable=SC2148

# https://github.com/jirsbek/SSH-keys-in-macOS-Sierra-keychain
[[ "$OSTYPE" == darwin* ]] && /usr/bin/ssh-add --apple-use-keychain
