(($+commands[ansible])) || return 0

VAULT=${0%/*}/bin/vault-keychain-client

export ANSIBLE_VAULT_ID_MATCH=true
export ANSIBLE_VAULT_IDENTITY_LIST="agross@$VAULT,
co-it@$VAULT,
heco@$VAULT,
kessler@$VAULT,
gw@$VAULT"
