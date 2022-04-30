#!/bin/bash

xdg-user-dirs-update

## Configure alacritty
mkdir -p $HOME/.config/alacritty
mv alacritty.yml $HOME/.config/alacritty/alacritty.yml

## Configure fish
mkdir -p $HOME/.config/fish
mv config.fish $HOME/.config/fish/config.fish

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
mv libvirt-groups $HOME/.local/bin/libvirt-groups
mv libvirt-usb $HOME/.local/bin/libvirt-usb
mv solo-session $HOME/.local/bin/solo-session

## Git
git clone https://aur.archlinux.org/yay $HOME/gitrepos/yay
cd $HOME/gitrepos/yay
makepkg -si --noconfirm
rm -rf $HOME/gitrepos

## Flatpak
flatpak install flathub com.obsproject.Studio --assumeyes

## AUR Packages
yay -S --needed --noconfirm minigalaxy itch-setup-bin polymc-bin mangohud noisetorch extramaus downgrade rider visual-studio-code-insiders-bin pfetch gnome-text-editor chrome-gnome-shell adw-gtk3 gnome-shell-extension-openweather-git nerd-fonts-jetbrains-mono amberol gnome-shell-extension-tiling-assistant-git brave-bin

echo "Run hp-setup [ip address of printer] to set up wireless printer"
echo "Authenticate github using github cli"
echo "Set up noisetorch systemd unit"
echo "Configure Samba shares"
echo "Install complete"
