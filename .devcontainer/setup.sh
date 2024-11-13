#!/bin/bash

# clone required repositories
gh repo clone Azure/azure-cli-extensions
gh repo clone Azure/azure-rest-api-specs
gh repo clone Azure/azure-rest-api-specs-pr
gh repo clone Azure/aaz

# setup development environment
source ./venv/bin/activate
pip install aaz-dev
azdev setup -c -r ./azure-cli-extensions
