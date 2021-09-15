#!/bin/bash

## Variables
ROOTPART="/dev/sda2"
HOSTNAME="arch"
ROOTPASSWD="password"
USERNAME="viraaj"
USERPASSWD="password"

## Set timezone and sync hardware clock
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

## Set locale
sed -i "160s/#//;177s/#//" /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf

## Configure hostname and hosts file
echo $HOSTNAME >> /etc/hostname
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$HOSTNAME.localdomain\t$HOSTNAME" >> /etc/hosts

## Install and configure bootloader (systemd-boot)
bootctl --path=/boot install
sed -i "s/default .*/default arch-*/" /boot/loader/loader.conf
echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\ninitrd\t/amd-ucode.img\ninitrd\t/initramfs-linux.img" >> /boot/loader/entries/arch.conf
## Comment below if using NVIDIA
echo -e "options\troot=PARTUUID=$(blkid -s PARTUUID -o value $ROOTPART) rw" >> /boot/loader/entries/arch.conf

## Add and configure users
echo "root:$ROOTPASSWD" | chpasswd
sed -i "82s/# //" /etc/sudoers
useradd -mG wheel $USERNAME
echo "$USERNAME:$USERPASSWD" | chpasswd

## Allow multilib installation, run full system upgrade, and install base packages
sed -i "93,94s/#//;37s/#//" /etc/pacman.conf
pacman -Syu --needed --noconfirm base-devel bash-completion networkmanager efibootmgr dosfstools mtools ntfs-3g xdg-user-dirs
systemctl enable NetworkManager.service

## Bluetooth
# pacman -S --needed --noconfirm bluez bluez-utils
# systemctl enable bluetooth.service

## Pipewire
# pacman -S --needed --noconfirm pipewire pipewire-pulse pipewire-jack pipewire-alsa

## OpenSSH
# pacman -S --needed --noconfirm openssh
# systemctl enable sshd.service

## Nvidia drivers
# pacman -S --needed --noconfirm nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia lib32-opencl-nvida libglvnd lib32-libglvnd
# sed -i "s/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf
# echo -e "options\troot=PARTUUID=$(blkid -s PARTUUID -o value $ROOTPART) rw nvidia-drm.modeset=1" >> /boot/loader/entries/arch.conf
# mkdir -p /etc/pacman.d/hooks
# echo -e "[Trigger]\nOperation=Install\nOperation=Upgrade\nOperation=Remove\nType=Package\nTarget=nvidia\n\n[Action]\nDepends=mkinitcpio\nWhen=PostTransaction\nExec=/usr/bin/mkinitcpio -P" >> /etc/pacman.d/hooks/nvidia

## VirtualBox
# pacman -S --needed --noconfirm virtualbox-guest-utils xf86-video-vmware
# systemctl enable vboxservice.service

## VMWare
# pacman -S --needed --noconfirm open-vm-tools gtkmm3 xf86-video-vmware
# systemctl enable vmtoolsd.service vmware-vmblock-fuse.service

## Desktop applications
# pacman -S --needed --noconfirm alacritty firefox thunderbird ark p7zip mpv pcmanfm gwenview kate libreoffice discord gimp gparted steam lutris dosbox kvantum-qt5 htop neofetch firewalld
# systemctl enable firewalld.service

## Plasma desktop
# pacman -S --needed --noconfirm xorg-server sddm plasma packagekit-qt5 libdbusmenu-glib appmenu-gtk-module
# systemctl enable sddm.service

## Fonts
# pacman -S --needed --noconfirm ttf-cascadia-code noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-liberation ttf-ubuntu-font-family ttf-font-awesome

## Device control
# pacman -S --needed --noconfirm piper

## Printing tools
# pacman -S --needed --noconfirm cups hplip
# systemctl enable cups.socket

## Programming
# pacman -S --needed --noconfirm code dotnet-runtime dotnet-sdk dotnet-hosts dotnet-targeting-pack python

## Virtualisation using qemu and libvirt
# pacman -S --needed --noconfirm qemu libvirt iptables-nft virt-manager virsh virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs
# systemctl enable libvirtd.service
# usermod -aG libvirt $USERNAME

echo "Please reboot and log into the $USERNAME account."
