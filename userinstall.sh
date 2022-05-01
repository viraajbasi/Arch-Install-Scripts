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

## AUR Packages
yay -S --needed --noconfirm itch-setup-bin noisetorch downgrade pfetch chrome-gnome-shell adw-gtk3 gnome-shell-extension-openweather-git nerd-fonts-jetbrains-mono gnome-shell-extension-tiling-assistant-git brave-bin snapd

## Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak update --appstream
flatpak install --assumeyes flathub com.obsproject.Studio com.valvesoftware.Steam com.github.tchx84.Flatseal io.github.sharkwouter.Minigalaxy org.polymc.PolyMC org.gnome.TextEditor io.bassi.Amberol net.davidotek.pupgui2 com.valvesoftware.Steam.CompatibilityTool.Proton-GE
flatpak install flathub-beta net.lutris.Lutris//beta

## Snap
sudo systemctl enable --now snapd.service
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install rider --classic
sudo snap install code-insiders --classic
sudo snap install teams
sudo snap install apple-music-for-linux

echo "Run hp-setup [ip address of printer] to set up wireless printer"
echo "Authenticate github using github cli"
echo "Set up noisetorch systemd unit"
echo "Configure Samba shares"
echo "Install complete"
