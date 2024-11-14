#!/bin/bash

# fork and clone required repositories
gh repo fork Azure/aaz --clone=true
gh repo fork Azure/azure-cli --clone=true
gh repo fork Azure/azure-cli-extensions --clone=true
gh repo clone Azure/azure-rest-api-specs
gh repo clone Azure/azure-rest-api-specs-pr

# setup development environment
pip install aaz-dev
azdev setup -c -r ./azure-cli-extensions
