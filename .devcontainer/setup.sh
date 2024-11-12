#!/bin/bash

# setup github cli
gh auth login

# clone required repositories
gh repo clone https://github.com/Azure/azure-cli-extensions.git ./azure-cli-extensions
gh repo clone https://github.com/Azure/azure-rest-api-specs.git ./azure-rest-api-specs
gh repo clone https://github.com/Azure/aaz.git ./aaz

# setup development environment
source ./venv/bin/activate
pip install aaz-dev
azdev setup -c -r ./azure-cli-extensions
