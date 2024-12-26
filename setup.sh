#!/bin/zsh

# Extract the OS information
os=$(lsb_release -si)

# Check if the OS is Ubuntu
if [ "$os" == "Ubuntu" ]; then
    echo "OS is Ubuntu. Checking out *ubuntu* branch..."
    git checkout ubuntu
    ./setup.sh
else
    echo "OS not detected. Proceeding with the default setup..."
fi

# Install omzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy dotfiles
cp ./.* ~/

