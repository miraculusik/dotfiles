#!/bin/zsh

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install Brew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

# Brew Taps
echo "Installing Brew Formulae..."
brew tap koekeishiya/formulae # yabai - skhd

brew install python
brew install rust
brew install node
npm install -g live-server
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install starship
brew install neofetch
brew install exa
brew install zoxide
brew install skhd
brew install yabai
brew install nnn
brew install ripgrep
brew install lazygit
brew install tmux
brew install gcc
brew install git
brew install fontforge

brew install --HEAD neovim

brew install --cask alacritty
brew install --cask alfred
brew install --cask appcleaner
brew install --cask calibre
brew install --cask monitorcontrol
brew install --cask spotify
brew install --cask ubersicht

# Spotify theme
brew install spicetify/homebrew-tap/spicetify-cli
