#!/bin/bash

## Update directories in ~
xdg-user-dirs-update

## Install custom keyboard layout with more characters
sudo mv evdev.xml /usr/share/X11/xkb/rules/evdev.xml
git clone https://github.com/jmrio/uk-intl-kb ~/gitrepos/ukkb
cd ~/gitrepos/ukkb
echo 'cat uk-intl-kb >> /usr/share/X11/xkb/symbols/gb' | sudo -s

## Configure neovim
mkdir -p ~/.config/nvim
echo -e "syntax on\nset smartindent\nset nu\nset smartcase\nset incsearch\nset hlsearch\nset tabstop=4\nset shiftwidth=4\nset noerrorbells\ncolorscheme desert" >> ~/.config/nvim/init.vim

## Install yay
git clone https://aur.archlinux.org/yay ~/gitrepos/yay
cd ~/gitrepos/yay
makepkg -si --noconfirm

## Qogir themes
## Qogir-gtk
# git clone https://github.com/vinceliuice/qogir-theme ~/gitrepos/qogir-theme
# cd ~/gitrepos/qogir-theme
# sudo pacman -S --needed --noconfirm gtk-engine-murrine gtk-engines
# ./install.sh
## Qogir-kde
# git clone https://github.com/vinceliuice/qogir-kde ~/gitrepos/qogir-kde
# cd ~/gitrepos/qogir-kde
# ./install.sh
## Qogir-icons
# git clone https://github.com/vinceliuice/qogir-icon-theme ~/gitrepos/qogir-icons
# cd ~/gitrepos/qogir-icons
# ./install.sh
## Ensure that the correct theme is selected in kvantum when using kde

## Remove ~/gitrepos
rm -rf ~/gitrepos

## Desktop applications
# yay -S --needed --noconfirm minigalaxy itch minecraft-launcher

## Programming
# yay -S --needed --noconfirm code-features code-icons code-marketplace unityhub

## Device control
# yay -S --needed --noconfirm openrgb

## Fonts
# yay -S --needed --noconfirm ttf-google-sans ttf-ms-win10-auto

## Gnome desktop applications, themes, and configuration for QT themes
# yay -S --needed --noconfirm chrome-gnome-shell gnome-shell-extension-dash-to-dock arc-gtk-theme
# echo "export QT_QPA_PLATFORMTHEME=qt5ct" | tee -a ~/.profile ~/.bash_profile

## Qogir theme
git clone

## Plasma desktop configuration for the global menu
# mkdir ~/.config/gtk-3.0
# echo -e "gtk-modules=\"appmenu-gtk-module\"" >> ~/.gtkrc-2.0
# echo -e "[Settings]\ngtk-modules=\"appmenu-gtk-module\"" >> ~/.config/gtk-3.0/settings.ini

echo "Install complete, the computer will reboot in 5 seconds"
sleep 5
reboot
