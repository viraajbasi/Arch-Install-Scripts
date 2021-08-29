#!/bin/bash

sudo mv evdev.xml /usr/share/X11/xkb/rules/evdev.xml

mkdir -p ~/.config/nvim
echo -e "syntax on\nset smartindent\nset nu\nset nowrap\nset smartcase\nset incsearch\nset tabstop=4\nset noerrorbells" >> ~/.config/nvim/init.vim

xdg-user-dirs-update

git clone https://aur.archlinux.org/yay ~/yay
cd ~/yay
makepkg -si --noconfirm

git clone https://github.com/jmrio/uk-intl-kb ~/ukkb
cd ~/ukkb
sudo cat uk-intl-kb >> /usr/share/X11/xkb/symbols/gb

yay -S --needed --noconfirm minigalaxy itch openrgb ttf-google-sans code-features code-icons code-marketplace
## If gnome is used instead of plasma
## comment the lines pertaining to appmenu-gtk-module
# yay -S --needed --noconfirm chrome-gnome-shell yaru-gtk-theme yaru-gnome-shell-theme-git gnome-shell-extension-dash-to-dock-git

mkdir ~/.config/gtk-3.0
echo -e "gtk-modules=\"appmenu-gtk-module\"" >> ~/.gtkrc-2.0 
echo -e "[Settings]\ngtk-modules=\"appmenu-gtk-module\"" >> ~/.config/gtk-3.0/settings.ini
