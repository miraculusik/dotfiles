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
brew tap homebrew/cask-fonts # Nerd fonts 
brew tap koekeishiya/formulae # yabai - skhd

brew install starship
brew install --HEAD dooit
brew install exa
brew install zoxide
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install skhd
brew install yabai
brew install nnn
brew install sf-symbols
brew install lazygit
brew install tmux
brew install gcc

brew install --HEAD neovim

brew install --cask alacritty
brew install --cask monitorcontrol
brew install --cask spotify
brew install --cask alfred
brew install --cask appcleaner
brew install --cask ubersicht

# Spotify theme
brew install spicetify/homebrew-tap/spicetify-cli
