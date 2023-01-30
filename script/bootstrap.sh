#!/usr/bin/env bash

set -e

# Create home/bin directory
mkdir -p $HOME/bin

# install Oh My zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install fzf 
# https://bytexd.com/how-to-use-fzf-command-line-fuzzy-finder/
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install Starship
# https://starship.rs/#quick-install
curl -sS https://starship.rs/install.sh > $HOME/bin/install_startship.sh
chmod +x $HOME/bin/install_startship.sh
$HOME/bin/install_startship.sh -b $HOME/bin
rm $HOME/bin/install_startship.sh

# Install asdf
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.11.1

exit 0