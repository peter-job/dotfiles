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

# Perform setup based on OS and branch
echo "OS is $os on branch $branch. Proceeding..."

#endregion

#region Install dependencies

# Install starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

#endregion

#region Sync dotfiles

# Copy dotfiles
cp ./.* ~/

#endregion

echo "Setup complete"
