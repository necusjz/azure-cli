#!/bin/bash

# setup github cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo apt update && sudo apt install gh -y
gh auth login

# clone required repositories
gh repo clone https://github.com/Azure/azure-cli-extensions.git ./azure-cli-extensions
gh repo clone https://github.com/Azure/azure-rest-api-specs.git ./azure-rest-api-specs
gh repo clone https://github.com/Azure/aaz.git ./aaz

# setup development environment
source ./venv/bin/activate
pip install aaz-dev
azdev setup -c -r ./azure-cli-extensions
