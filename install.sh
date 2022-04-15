#!/bin/bash

################################################################################################################
# This script assumes the following:                                                                           #
# The PC is using UEFI boot.                                                                                   #
# The packages "base, base-devel, linux-zen, linux-zen-headers, linux-firmware, amd-ucode, git" are installed. #
# The desired locale, language, and timezone are for the UK.                                                   #
################################################################################################################

## Variables
ROOTPART="/dev/sda2"
HOSTNAME="arch"
ROOTPASSWD="password"
USERNAME="viraaj"
USERPASSWD="password"
USERSHELL="fish"

## Set timezone and sync hardware clock
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

## Set locale
sed -i "161s/#//;178s/#//" /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf

## Configure hostname and hosts file
echo $HOSTNAME >> /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$HOSTNAME.localdomain\t$HOSTNAME" >> /etc/hosts

## Install and configure bootloader (systemd-boot)
bootctl --path=/boot install
sed -i "s/default .*/default arch.conf/" /boot/loader/loader.conf
echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux-zen\ninitrd\t/amd-ucode.img\ninitrd\t/initramfs-linux-zen.img\noptions\troot=PARTUUID=$(blkid -s PARTUUID -o value $ROOTPART) rw" >> /boot/loader/entries/arch.conf

## Add and configure users
echo "root:$ROOTPASSWD" | chpasswd
sed -i "82s/# //" /etc/sudoers
useradd -mG wheel,sys,adm,games,ftp,http,floppy,optical,storage $USERNAME
echo "$USERNAME:$USERPASSWD" | chpasswd

## Allow multilib installation, run full system upgrade, and install base packages
sed -i "93,94s/#//;36,37s/#//;33s/#//;38iILoveCandy" /etc/pacman.conf
pacman -Syu --needed --noconfirm networkmanager efibootmgr man-db inetutils wget reflector dosfstools mtools ntfs-3g exfat-utils bluez bluez-utils firewalld pipewire pipewire-pulse pipewire-jack pipewire-alsa openssh which $USERSHELL
systemctl enable NetworkManager.service bluetooth.service firewalld.service sshd.service
echo -e "--save /etc/pacman.d/mirrorlist\n--country 'United Kingdom'\n--protocol https\n--latest 5\n --sort age" > /etc/xdg/reflector/reflector.conf
systemctl enable reflector.timer

## Set default shell
usermod -s $(which $USERSHELL) $USERNAME
# echo -e "export ZDOTDIR=\"$HOME\"/.config/zsh" >> /etc/zshenv 

## Nvidia drivers
pacman -S --needed --noconfirm nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia libglvnd lib32-libglvnd
sed -i "s/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf
sed -i "5s/$/ nvidia-drm.modeset=1/" /boot/loader/entries/arch.conf
mkdir -p /etc/pacman.d/hooks
echo -e "[Trigger]\nOperation=Install\nOperation=Upgrade\nOperation=Remove\nType=Package\nTarget=nvidia-dkms\n\n[Action]\nDepends=mkinitcpio\nWhen=PostTransaction\nExec=/usr/bin/mkinitcpio -P" >> /etc/pacman.d/hooks/nvidia.hook
echo -e "ACTION==\"add\", DEVPATH==\"/bus/pci/drivers/nvidia\", RUN+=\"/usr/bin/nvidia-modprobe -c0 -u\"" >> /etc/udev/rules.d/70-nvidia.rules
mkinitcpio -P

## VirtualBox VM tools
# pacman -S --needed --noconfirm virtualbox-guest-utils xf86-video-vmware
# systemctl enable vboxservice.service

## VMWare VM tools
# pacman -S --needed --noconfirm open-vm-tools gtkmm3 xf86-video-vmware
# systemctl enable vmtoolsd.service vmware-vmblock-fuse.service

## Desktop applications
pacman -S --needed --noconfirm kitty thunderbird libreoffice discord btop neofetch gnome-calculator mpv ncdu obs-studio steam lutris gnome-keyring gamemode lib32-gamemode xorg-server wayland xwayland noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-liberation ttf-font-awesome ttf-fira-code nerd-fonts-fira-code piper dotnet-runtime dotnet-sdk dotnet-host dotnet-targeting-pack python nodejs npm mono mono-msbuild aspnet-runtime github-cli rust rust-src neovim qt5-wayland

## Plasma desktop
# pacman -S --needed --noconfirm sddm plasma packagekit-qt5 libdbusmenu-glib appmenu-gtk-module latte-dock kvantum plasma-wayland-session xdg-desktop-portal-kde
# pacman -S --needed --noconfirm ark notepadqq dolphin dolphin-plugins gwenview partitionmanager okular
# systemctl enable sddm.service

## Gnome desktop
# pacman -S --needed --noconfirm gnome-shell gnome-backgrounds gnome-color-manager gnome-control-center gnome-menus gnome-screenshot gnome-terminal gnome-shell-extensions gnome-themes-extra gnome-tweaks gnome-weather xdg-desktop-portal-gnome gdm
# pacman -S --needed --noconfirm dconf-editor eog evince file-roller nautilus simple-scan gnome-disk-utility
# systemctl enable gdm.service
# ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

## Printing tools
pacman -S --needed --noconfirm cups hplip system-config-printer python-pyqt5
systemctl enable cups.socket
usermod -aG lp,scanner $USERNAME

## Virtualisation using qemu and libvirt
yes | pacman -S --needed qemu libvirt iptables-nft virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs swtpm ovmf
systemctl enable libvirtd.service
usermod -aG libvirt $USERNAME

echo "Please reboot and log into the $USERNAME account."
