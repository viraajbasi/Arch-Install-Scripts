#!/bin/bash

curl -L https://get.oh-my.fish > install
fish install --path=~/.local/share/omf --config=~/.config/omf
# omf install chain
# omf theme chain
exit
echo "set fish_greeting" >> ~/.config/fish/config.fish

sudo mv evdev.xml /usr/share/X11/xkb/rules/evdev.xml

mkdir -p ~/.config/nvim
echo -e "syntax on\nset smartindent\nset nu\nset nowrap\nset smartcase\nset incsearch\nset tabstop=4\nset noerrorbells" >> ~/.config/nvim/init.vim

xdg-user-dirs-update

git clone https://aur.archlinux.org/yay
cd yay
makepkg -si
cd ..

git clone https://github.com/jmrio/uk-intl-kb
cd uk-intl-kb
sudo cat uk-intl-kb >> /usr/share/X11/xkb/symbols/gb
cd ..

curl -L https://github.com/ISmellACommie/Arch-Install-Scripts/releases/download/1.0/WindowsFonts.zip > WindowsFonts.zip
mkdir WindowsFonts
unzip WindowsFonts.zip -d WindowsFonts
rm -rf WindowsFonts.zip
sudo mv WindowsFonts /usr/share/fonts
chmod 644 /usr/share/fonts/WindowsFonts/*
fc-cache --force

yay -S --needed minigalaxy itch openrgb ttf-google-sans code-features code-icons code-marketplace

echo -e "gtk-modules=\"appmenu-gtk-module\"" | tee -a ~/.gtkrc-2.0 ~/.config/gtk-3.0/settings.ini
