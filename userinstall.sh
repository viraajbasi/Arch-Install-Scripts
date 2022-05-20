#!/bin/bash

xdg-user-dirs-update

## Configure neovim
mkdir -p $HOME/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo npm -g install instant-markdown-d
mv init.vim $HOME/.config/nvim/init.vim
nvim +silent +PlugInstall +qall

## Place desktop files
mkdir -p $HOME/.local/share/applications
mv *.desktop $HOME/.local/share/applications

## User binaries
mkdir -p $HOME/.local/bin
mv gscript $HOME/.local/bin/gscript
mv libvirt-groups $HOME/.local/bin/libvirt-groups
mv libvirt-usb $HOME/.local/bin/libvirt-usb
mv solo-session $HOME/.local/bin/solo-session

## Configure bash
mkdir -p $HOME/.local/state/bash
mv bashrc $HOME/.local/state/bash
mv bash_profile $HOME/.local/state/bash

## Configure sxhkdrc
mkdir -p $HOME/.config/sxhkd
mv sxhkdrc $HOME/.config/sxhkd/sxhkdrc

## Configure X11
mkdir -p $HOME/.config/X11
mv xinitrc $HOME/.config/X11/xinitrc
mv xsession $HOME/.config/X11/xsession

## yay
git clone https://aur.archlinux.org/yay $HOME/gitrepos/yay
cd $HOME/gitrepos/yay
makepkg -si --noconfirm
rm -rf $HOME/gitrepos
mkdir -p $HOME/Documents/src

## dwm
git clone https://github.com/viraajbasi/dwm $HOME/Documents/src/dwm
chmod +x $HOME/Documents/src/dwm/build.sh
$HOME/Documents/src/dwm/build.sh

## st
git clone https://github.com/viraajbasi/st $HOME/Documents/src/st
chmod +x $HOME/Documents/src/st/build.sh
$HOME/Documents/src/st/build.sh

## dmenu
git clone https://github.com/viraajbasi/dmenu $HOME/Documents/src/dmenu
chmod +x $HOME/Documents/src/dmenu/build.sh
$HOME/Documents/src/dmenu/build.sh

## slock
git clone https://github.com/viraajbasi/slock $HOME/Docuements/src/slock
cd $HOME/Documents/src/slock
sudo make clean install

## AUR Packages
yay -S --needed --noconfirm itch-setup-bin downgrade nerd-fonts-cascadia-code cider polymc rider teams ttf-google-sans visual-studio-code-insiders-bin heroic-games-launcher-bin mailspring morgen-bin clion clion-jre nsxiv onloffice-bin ttf-ms-win11-auto

echo "Run hp-setup [ip address of printer] to set up wireless printer"
echo "Authenticate github using github cli"
echo "Install complete"
