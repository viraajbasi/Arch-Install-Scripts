#!/bin/bash

sudo mv evdev.xml /usr/share/X11/xkb/rules/evdev.xml

mkdir -p ~/.config/nvim
echo -e "syntax on\nset smartindent\nset nu\nset smartcase\nset incsearch\nset tabstop=4\nset noerrorbells" >> ~/.config/nvim/init.vim

git clone https://aur.archlinux.org/yay ~/gitrepos/yay
cd ~/gitrepos/yay
makepkg -si --noconfirm

git clone https://github.com/jmrio/uk-intl-kb ~/gitrepos/ukkb
cd ~/gitrepos/ukkb
echo 'cat uk-intl-kb >> /usr/share/X11/xkb/symbols/gb' | sudo -s

yay -S --needed --noconfirm minigalaxy itch openrgb ttf-google-sans code-features code-icons code-marketplace

mkdir ~/.config/gtk-3.0
echo -e "gtk-modules=\"appmenu-gtk-module\"" >> ~/.gtkrc-2.0 
echo -e "[Settings]\ngtk-modules=\"appmenu-gtk-module\"" >> ~/.config/gtk-3.0/settings.ini
