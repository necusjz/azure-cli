
export GITHUB_TOKEN=  # logout default account

if gh auth status -a | grep 'Token scopes: ' | grep -q 'repo'; then  # check `repo` scope exists or not
    echo "You were already logged in to GitHub."
else
    gh auth login -p https -w
fi
