#!/bin/bash

# clone required repositories
git clone https://github.com/Azure/azure-cli-extensions.git /workspaces/azure-cli-extensions
git clone https://github.com/Azure/azure-rest-api-specs.git /workspaces/azure-rest-api-specs
git clone https://github.com/Azure/aaz.git /workspaces/aaz

# setup development environment
cd /workspaces
python -m venv venv
source ./venv/bin/active
pip install aaz-dev
azdev setup -c -r ./azure-cli-extensions

# run codegen tool
aaz-dev run -c ./azure-cli -e ./azure-cli-extensions -s ./azure-rest-api-specs -a ./aaz
