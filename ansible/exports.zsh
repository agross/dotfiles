(($+commands[ansible])) || return 0
[[ "$OSTYPE" == darwin* ]] || return 0

VAULT=${0%/*}/bin/vault-keychain-client

export ANSIBLE_VAULT_ID_MATCH=true
export ANSIBLE_VAULT_IDENTITY_LIST="agross@$VAULT,
agross2@$VAULT,
co-it@$VAULT,
heco@$VAULT,
kessler@$VAULT,
gw@$VAULT"
