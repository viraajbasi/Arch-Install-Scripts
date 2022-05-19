#!/bin/bash

################################################################################################################
# This script assumes the following:                                                                           #
# The PC is using UEFI boot.                                                                                   #
# The packages "base, base-devel, linux, linux-headers, linux-firmware, amd-ucode, git" are installed.         #
# The desired locale, language, and timezone are for the UK.                                                   #
################################################################################################################

## Variables
ROOTPART="/dev/sda2"
HOSTNAME="arch"
ROOTPASSWD="password"
NAME="viraaj"
PASSWORD="password"

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

## Configure pacman
sed -i "72,73s/#//;81,82s/#//;90,91s/#//;93,94s/#//;36,37s/#//;33s/#//;38iILoveCandy" /etc/pacman.conf
pacman -Syy

## Nvidia drivers
pacman -S --needed --noconfirm nvidia-open-dkms nvidia-utils nvidia-settings opencl-nvidia libglvnd lib32-nvidia-utils
sed -i "s/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf
mkdir -p /etc/pacman.d/hooks
echo -e "[Trigger]\nOperation=Install\nOperation=Upgrade\nOperation=Remove\nType=Package\nTarget=nvidia-dkms\n\n[Action]\nDepends=mkinitcpio\nWhen=PostTransaction\nExec=/usr/bin/mkinitcpio -P" >> /etc/pacman.d/hooks/nvidia.hook
echo -e "ACTION==\"add\", DEVPATH==\"/bus/pci/drivers/nvidia\", RUN+=\"/usr/bin/nvidia-modprobe -c0 -u\"" >> /etc/udev/rules.d/70-nvidia.rules
mkinitcpio -P

## Run full system upgrade, and install packages
pacman -S --needed --noconfirm efibootmgr man-db wget reflector dosfstools bluez bluez-utils pipewire pipewire-pulse pipewire-jack pipewire-alsa openssh which discord btop neofetch ncdu gnome-keyring gamemode noto-fonts noto-fonts-cjk noto-fonts-extra piper dotnet-runtime dotnet-sdk dotnet-host dotnet-targeting-pack python nodejs npm mono mono-msbuild github-cli neovim cups hplip python-pyqt5 qemu libvirt virt-manager dnsmasq vde2 bridge-utils openbsd-netcat libguestfs swtpm ovmf xdg-user-dirs ttf-joypixels steam iwd ufw mate-calc zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps pcmanfm flameshot gnome-themes-extra xarchiver xed obs-studio xorg mpv gparted dunst sxhkd bitwarden bash-completion arc-gtk-theme arc-icon-theme wqy-zenhei xclip ttf-liberation font-manager pamixer
yes | pacman -S iptables-nft
usermod -aG libvirt $NAME
echo -e "--save /etc/pacman.d/mirrorlist\n--country 'United Kingdom'\n--protocol https\n--latest 5\n--sort age" > /etc/xdg/reflector/reflector.conf
systemctl enable iwd.service bluetooth.service ufw.service sshd.service reflector.timer cups.service libvirtd.service

## Add and configure users
echo "root:$ROOTPASSWD" | chpasswd
sed -i "82s/# //" /etc/sudoers
useradd -mG wheel,sys,adm,games,ftp,http,floppy,optical,storage,lp,scanner $NAME
echo "$NAME:$PASSWORD" | chpasswd

## Configure global bashrc
cat bash_config >> /etc/bash.bashrc

## Create Unified Kernel Image
mkdir -p /etc/minitcpio.d
mv linux-zen.preset /etc/mkinitcpio.d/linux-zen.preset
mkdir -p /etc/kernel
echo -e "root=PARTUUID=$(blkid -s PARTUUID -o value $ROOTPART) rw nvidia-drm.modeset=1 amd_iommu=on iommu=pt loglevel=2 pcie_acs_override=downstream,multifunction quiet splash" >> /etc/kernel/cmdline
mkinitcpio -P

echo "Please reboot and log into the $NAME account."
