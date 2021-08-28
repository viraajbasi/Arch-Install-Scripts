#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

sed -i "160s/#//;177s/#//" /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf

echo "arch" >> /etc/hostname
echo -e "127.0.1.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tarch.localdomain\tarch" >> /etc/hosts

bootctl --path=/boot install
sed -i "s/default .*/default arch-*/" /boot/loader/loader.conf
echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\ninitrd\t/initramfs-linux.img\noptions\troot=/dev/sda2 rw" >> /boot/loader/entries/arch.conf

echo "root:password" | chpasswd
sed -i "82s/# //" /etc/sudoers
useradd -mG wheel viraaj
echo "viraaj:password" | chpasswd

sed -i "93,94s/#//;37s/#//" /etc/pacman.conf
pacman -Syu --needed --noconfirm base-devel fish networkmanager bluez bluez-utils efibootmgr dosfstools mtools ntfs-3g xdg-user-dirs pipewire pipewire-pulse pipewire-jack pipewire-alsa htop neofetch ttf-font-awesome noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra p7zip firewalld openssh

systemctl enable NetworkManager.service bluetooth.service firewalld.service sshd.service

## Nvidia drivers
# pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings

## Utility programs
# pacman -S --noconfirm firefox libreoffice gimp discord cups hplip piper 
# systemctl enable cups.socket

## Programming
# pacman -S --noconfirm code dotnet-runtime dotnet-sdk dotnet-hosts dotnet-targeting-pack

## Theming
# pacman -S --noconfirm papirus-icon-theme kvantum-qt5

## Plasma desktop
# pacman -S --noconfirm xorg-server sddm plasma kde-applications packagekit-qt5 libdbusmenu-glib appmenu-gtk-module latte-dock
# systemctl enable sddm.service

## Gnome desktop
# pacman -S --noconfirm xorg-server gdm gnome gnome-extra gnome-tweaks qt5ct
# systemctl enable gdm.service

## Game-related software
# pacman -S --noconfirm steam lutris dosbox

## For VirtualBox
# pacman -S --noconfirm virtualbox-guest-utils xf86-video-vmware
# systemctl enable vboxservice

## For VMware
# pacman -S --noconfirm open-vm-tools gtkmm3 xf86-video-vmware
# systemctl enable vmtoolsd.service vmware-vmblock-fuse.service

chsh -s /bin/fish viraaj
