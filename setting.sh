#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 git_user_name git_email"
    return
fi

git_user_name=$1
git_email=$2

# Generate SSH keys
ssh-keygen -t rsa -b 4096 -C $git_email
echo "SSH keys for $git_user_name with email $git_email have been generated"
echo "Your ssh key is below"
echo "$(cat ~/.ssh/id_rsa.pub)"

# Configure Git
git config --global user.name $git_user_name
git config --global user.email $git_email
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.st status
git config --global alias.cm commit
git config --global alias.ps push

git config --global core.editor "vim"
echo "Git has been configured with user name '$git_user_name', email '$git_email', and some aliases."

# Check if the current operating system is macOS
if [[ $(uname) == "Darwin" ]]; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Configure Homebrew environment variables
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.profile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.profile
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Install required packages
    brew install --cask visual-studio-code
    brew install jadx
    brew install go

    export PATH=$PATH:/usr/local/go/bin:/usr/local/go/bin:$HOME/go/bin

    # Add Homebrew environment variables to .profile
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
