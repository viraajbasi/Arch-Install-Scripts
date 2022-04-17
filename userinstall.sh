#!/bin/bash

######################################################
# This script assumes the following:                 #
# git, and kitty are installed.                      #
# neovim is the desired text editor for the console. #
# The user directories are correctly generated.      #
######################################################

## Configure kitty
mkdir -p ~/.config/kitty
mv kitty.conf ~/.config/kitty/kitty.conf

## Configure fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
mkdir -p ~/.config/fish
mv config.fish ~/.config/fish/config.fish

## Environment variables for wayland
mkdir -p ~/.config/environment.d/
echo -e "QT_QPA_PLATFORM=\"wayland;xcb\"\nCLUTTER_BACKEND=wayland\nSDL_VIDEODRIVER=wayland\nGBM_BACKEND=nvidia-drm\n__GLX_VENDOR_LIBRARY_NAME=nvidia\nMOZ_ENABLE_WAYLAND=1\nQT_QPA_PLATFORMTHEME=qt5ct" >> ~/.config/environment.d/envvars.conf

## Configure neovim
mkdir -p ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo npm -g install instant-markdown-d
mv init.vim ~/.config/nvim/init.vim

## Configure starship prompt
mv starship.toml ~/.config/starship.toml

## Install yay
git clone https://aur.archlinux.org/yay ~/gitrepos/yay
cd ~/gitrepos/yay
makepkg -si --noconfirm

## Sticky window snapping kwin extension
# git clone https://github.com/Flupp/sticky-window-snapping ~/gitrepos/window
# cd ~/gitrepos/window
# ./kpackagetool-install.bash

## Remove ~/gitrepos
rm -rf ~/gitrepos

## Dotnet
mkdir -p ~/.local/bin
wget https://dot.net/v1/dotnet-install.sh -O ~/.local/bin/dotnet-install

## Gnome
yay -S gnome-text-editor gnome-shell-extension-pop-shell-git chrome-gnome-shell adw-gtk3

## AUR Packages
yay -S --needed --noconfirm papirus-libreoffice-theme minigalaxy itch-setup-bin minecraft-launcher mangohud noisetorch extramaus downgrade unityhub rider visual-studio-code-insiders-bin ttf-google-sans pfetch openrgb papirus-libreoffice-theme

echo "Run ':PlugInstall' inside neovim to complete vim-plug installation"
echo "Run hp-setup [ip address of printer] to set up wireless printer"
echo "Modify the desktop files of game launchers to include 'gamemoderun'"
echo "Authenticate github using github cli"
echo "Set up noisetorch systemd unit"
echo "Install complete"
