#!/bin/bash

# clone required repositories
git clone https://github.com/Azure/azure-cli-extensions.git ./azure-cli-extensions
git clone https://github.com/Azure/azure-rest-api-specs.git ./azure-rest-api-specs
git clone https://github.com/Azure/aaz.git ./aaz

# setup development environment
source ./venv/bin/activate
pip install aaz-dev
azdev setup -c -r ./azure-cli-extensions
