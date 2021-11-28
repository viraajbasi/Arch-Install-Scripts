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
mkdir -p ~/.config/fish
mv config.fish ~/.config/fish/config.fish

## Configure neovim
mkdir -p ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo npm -g install instant-markdown-d
mv init.vim ~/.config/nvim/init.vim

## Configure starship prompt
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --force --yes
mv starship.toml ~/.config/starship.toml

## Install custom keyboard layout with more characters
sudo mv evdev.xml /usr/share/X11/xkb/rules/evdev.xml
git clone https://github.com/jmrio/uk-intl-kb ~/gitrepos/ukkb
cd ~/gitrepos/ukkb
echo 'cat uk-intl-kb >> /usr/share/X11/xkb/symbols/gb' | sudo -s

## Install yay
git clone https://aur.archlinux.org/yay ~/gitrepos/yay
cd ~/gitrepos/yay
makepkg -si --noconfirm

## Qogir-gtk
git clone https://github.com/vinceliuice/qogir-theme ~/gitrepos/qogir-theme
cd ~/gitrepos/qogir-theme
./install.sh

## Qogir-kde
git clone https://github.com/vinceliuice/qogir-kde ~/gitrepos/qogir-kde
cd ~/gitrepos/qogir-kde
./install.sh

## Layan-gtk
git clone https://github.com/vinceliuice/layan-gtk-theme ~/gitrepos/layan-gtk
cd ~/gitrepos/layan-gtk
./install.sh

## Layan-kde
git clone https://github.com/vinceliuice/layan-kde ~/gitrepos/layan-kde
cd ~/gitrepos/layan-kde
./install.sh

## Tela icons
git clone https://github.com/vinceliuice/tela-icon-theme ~/gitrepos/tela-icon-theme
cd ~/gitrepos/tela-icon-theme
./install.sh -a

## Sticky window snapping kwin extension
git clone https://github.com/Flupp/sticky-window-snapping ~/gitrepos/window
cd ~/gitrepos/window
./kpackagetool-install.bash

## Remove ~/gitrepos
rm -rf ~/gitrepos

## Libreoffice theme
yay -S --needed --noconfirm papirus-libreoffice-theme

## Gaming
yay -S --needed --noconfirm minigalaxy itch minecraft-launcher

## Desktop applications
yay -S --needed --noconfirm spotify brave-bin

## Programming
yay -S --needed --noconfirm code-features code-icons code-marketplace unityhub rider

## Device control
yay -S --needed --noconfirm openrgb

## Themes
yay -S --needed --noconfirm arc-kde-git

## Fonts
yay -S --needed --noconfirm ttf-google-sans ttf-ms-win10-auto

## Microsoft
yay -S --needed --noconfirm teams

## Plasma gtk configuration for the global menu
mkdir ~/.config/gtk-3.0
echo -e "gtk-modules=\"appmenu-gtk-module\"" >> ~/.gtkrc-2.0
echo -e "[Settings]\ngtk-modules=\"appmenu-gtk-module\"" >> ~/.config/gtk-3.0/settings.ini

echo "Run ':PlugInstall' inside neovim to complete vim-plug installation"
echo "Install complete"
