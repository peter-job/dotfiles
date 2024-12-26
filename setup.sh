#!/bin/zsh

# Extract the OS information
os=$(lsb_release -si)
branch=$(git branch --show-current)

# Check if the OS is Ubuntu
if [ "$os" = "Ubuntu" ] && [ "$branch" != "ubuntu" ]; then
    echo "OS is Ubuntu. Checking out *ubuntu* branch..."
    git fetch origin ubuntu
    git checkout ubuntu
    ./setup.sh
elif [ "$os" = "Ubuntu" ] && [ "$branch" = "ubuntu" ]; then
    echo "OS is Ubuntu. Proceeding with the setup..."
else
    echo "Unsupported OS. Exiting..."
    exit 1
fi

# Install omzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy dotfiles
cp ./.* ~/

