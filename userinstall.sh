#!/bin/bash

######################################################
# This script assumes the following:                 #
# git, and kitty are installed.                      #
# neovim is the desired text editor for the console. #
# The user directories are correctly generated.      #
######################################################

## Place kitty config file in correct location and modify
mkdir ~/.config/kitty
cp /usr/share/doc/kitty/kitty.conf ~/.config/kitty/kitty.conf
sed -i "9s/font_family .*/font_family      Cascadia Code/;762s/background_opacity .*/background_opacity 0.75/" ~/.config/kitty/kitty.conf

## Install custom keyboard layout with more characters
sudo mv evdev.xml /usr/share/X11/xkb/rules/evdev.xml
git clone https://github.com/jmrio/uk-intl-kb ~/gitrepos/ukkb
cd ~/gitrepos/ukkb
echo 'cat uk-intl-kb >> /usr/share/X11/xkb/symbols/gb' | sudo -s

## Configure neovim
mkdir -p ~/.config/nvim
echo -e "syntax on\nset smartindent\nset nu\nset smartcase\nset incsearch\nset hlsearch\nset tabstop=4\nset shiftwidth=4\nset noerrorbells\ncolorscheme desert" >> ~/.config/nvim/init.vim

## Configure bash
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --force --yes
echo -e "[line_break]\ndisabled = true" >> ~/.config/starship.toml
echo -e "alias weather=\"curl wttr.in\"\nalias g=\"git\"\nalias vim=\"nvim\"\nalias sysup=\"yay -Syu\"\nalias install=\"yay -S\"\nalias remove=\"yay -Rcns\"\nalias search=\"yay -Ss\"\nalias ytdl=\"youtube-dl\"\neval \"\$(starship init bash)\"" >> ~/.bashrc

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
yay -S --needed --noconfirm spotify

## Programming
yay -S --needed --noconfirm code-features code-icons code-marketplace unityhub

## Device control
yay -S --needed --noconfirm openrgb

## Fonts
yay -S --needed --noconfirm ttf-google-sans ttf-ms-win10-auto

## Microsoft
yay -S --needed --noconfirm teams microsoft-edge-dev-bin

## Plasma gtk configuration for the global menu
mkdir ~/.config/gtk-3.0
echo -e "gtk-modules=\"appmenu-gtk-module\"" >> ~/.gtkrc-2.0
echo -e "[Settings]\ngtk-modules=\"appmenu-gtk-module\"" >> ~/.config/gtk-3.0/settings.ini

echo "Install complete, the computer will reboot in 5 seconds"
sleep 5
reboot
