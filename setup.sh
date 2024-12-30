#!/usr/bin/env bash

# Setup script for my dotfiles
# Todo: I don't like using branches to manage different OSes. If they never converge, seems like a bad idea.

HOME_DIR=~

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

# Copy repo, excluding .git directory and non-dotfiles
rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "setup.sh" \
    --exclude "dotfiles.code-workspace" \
    --exclude "readme.md" \
    -avh --no-perms . $HOME_DIR

# Copy .git directory, exactly mirroring repo
rsync --archive --delete --verbose --no-perms .git/ $HOME_DIR/.git

#endregion

echo "Setup complete. Starting a new zsh session..."
zsh
