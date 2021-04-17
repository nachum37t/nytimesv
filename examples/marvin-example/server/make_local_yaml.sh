#!/bin/sh

export VAULT_ADDR="https://vault.your-company.com";

vault login -method=github token=`cat ~/.config/vault/github` > /dev/null 2>&1;

cat > local.yaml <<EOF
runtime: go
api_version: go1.9
module: myservice

handlers:
- url: /.*
  script: _go_app

env_variables:
  VAULT_LOCAL_TOKEN: "`cat ~/.vault-token`"
  VAULT_ADDR: https://vault.your-company.com
  VAULT_SECRET_PATH: "repo-name/secret/my-secrets"
EOF

