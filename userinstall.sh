#!/bin/bash

## Configure alacritty
mkdir -p $HOME/.config/alacritty
mv alacritty.yml $HOME/.config/alacritty/alacritty.yml

## Configure fish
mkdir -p $HOME/.config/fish
mv config.fish $HOME/.config/fish/config.fish

## Environment variables for wayland
mkdir -p $HOME/.config/environment.d/
echo -e "QT_QPA_PLATFORM=\"wayland;xcb\"\nCLUTTER_BACKEND=wayland\nSDL_VIDEODRIVER=wayland\nGBM_BACKEND=nvidia-drm\n__GLX_VENDOR_LIBRARY_NAME=nvidia\nMOZ_ENABLE_WAYLAND=1\nQT_QPA_PLATFORMTHEME=qt5ct" >> $HOME/.config/environment.d/envvars.conf

## Configure neovim
mkdir -p $HOME/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo npm -g install instant-markdown-d
mv init.vim $HOME/.config/nvim/init.vim
nvim +silent +PlugInstall +qall

## Configure starship prompt
mv starship.toml $HOME/.config/starship.toml

## Place desktop files
mkdir -p $HOME/.local/share/applications
mv *.desktop $HOME/.local/share/applications

## User binaries
mkdir -p $HOME/.local/bin
mv gscript $HOME/.local/bin/gscript

## Install yay
git clone https://aur.archlinux.org/yay $HOME/gitrepos/yay
cd $HOME/gitrepos/yay
makepkg -si --noconfirm
rm -rf $HOME/gitrepos

## AUR Packages
yay -S --needed --noconfirm papirus-libreoffice-theme minigalaxy itch-setup-bin minecraft-launcher mangohud noisetorch extramaus downgrade rider visual-studio-code-insiders-bin ttf-google-sans pfetch papirus-libreoffice-theme gnome-text-editor gnome-shell-extension-pop-shell-git chrome-gnome-shell adw-gtk3 gnome-shell-extension-openweather-git nerd-fonts-jetbrains-mono
echo "Run hp-setup [ip address of printer] to set up wireless printer"
echo "Authenticate github using github cli"
echo "Set up noisetorch systemd unit"
echo "Configure Samba shares"
echo "Install complete"
