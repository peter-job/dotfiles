#!/usr/bin/env bash

# Setup script for my dotfiles
# Todo: I don't like using branches to manage different OSes. If they never converge, seems like a bad idea.

#region Check OS and branch (WIP)

# Extract the OS information
os=$(uname -s)
branch=$(git branch --show-current)

# Normalize the OS name
if [ "$os" = "Darwin" ]; then
    os="macOS"
elif [ "$os" = "Linux" ]; then
    os=$(lsb_release -si)
fi

# Check the OS and branch
if [ "$os" = "Ubuntu" ] && [ "$branch" = "ubuntu" ]; then
    echo "OS is Ubuntu, on branch ubuntu. Proceeding..."
else
    echo "OS is $os on branch $branch. Proceeding..."
    exit 1
fi

#endregion

#region Install dependencies

# Install omzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#endregion

#region Sync dotfiles

# Copy dotfiles
cp ./.* ~/

#endregion

echo "Setup complete"
