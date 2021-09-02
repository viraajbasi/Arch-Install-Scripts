#!/bin/bash

## Variables
# Change these to match system
ROOTPART="/dev/sda2"
HOSTNAME="arch"
ROOTPASSWD="password"
USERNAME="viraaj"
USERPASSWD="password"

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

sed -i "160s/#//;177s/#//" /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf

echo $HOSTNAME >> /etc/hostname
echo -e "127.0.1.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$HOSTNAME.localdomain\t$HOSTNAME" >> /etc/hosts

bootctl --path=/boot install
sed -i "s/default .*/default arch-*/" /boot/loader/loader.conf
echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\ninitrd\t/amd-ucode.img\ninitrd\t/initramfs-linux.img" >> /boot/loader/entries/arch.conf
## Comment below if using NVIDIA
echo -e "options\troot=PARTUUID=$(blkid -s PARTUUID -o value $ROOTPART) rw" >> /boot/loader/entries/arch.conf

echo "root:$ROOTPASSWD" | chpasswd
sed -i "82s/# //" /etc/sudoers
useradd -mG wheel $USERNAME
echo "$USERNAME:$USERPASSWD" | chpasswd

sed -i "93,94s/#//;37s/#//" /etc/pacman.conf
pacman -Syu --needed --noconfirm base-devel bash-completion networkmanager efibootmgr dosfstools mtools ntfs-3g

systemctl enable NetworkManager.service

## Bluetooth
# pacman -S --needed --noconfirm bluez bluez-utils
# systemctl enable bluetooth.service

## OpenSSH
# pacman -S --needed --noconfirm openssh
# systemctl enable sshd.service

## Nvidia drivers
# pacman -S --needed --noconfirm nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia lib32-opencl-nvida libglvnd lib32-libglvnd 
# sed -i "s/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/" /etc/mkinitcpio.conf
# echo -e "options\troot=PARTUUID=$(blkid -s PARTUUID -o value $ROOTPART) rw nvidia-drm.modeset=1" >> /boot/loader/entries/arch.conf
# mkdir -p /etc/pacman.d/hooks
# echo -e "[Trigger]\nOperation=Install\nOperation=Upgrade\nOperation=Remove\nType=Package\nTarget=nvidia\n\n[Action]\nDepends=mkinitcpio\nWhen=PostTransaction\nExec=/usr/bin/mkinitcpio -P" >> /etc/pacman.d/hooks/nvidia

## Desktop applications
# pacman -S --needed --noconfirm konsole firefox thunderbird dolphin dolphin-plugins ark p7zip kate vlc gwenview okular libreoffice gimp discord piper gparted code steam lutris dosbox papirus-icon-theme kvantum-qt5 htop neofetch

### Printing tools
# pacman -S cups hplip
# systemctl enable cups.socket

## Programming
# pacman -S --needed --noconfirm dotnet-runtime dotnet-sdk dotnet-hosts dotnet-targeting-pack python

## Plasma desktop
# pacman -S --needed --noconfirm xorg-server sddm plasma packagekit-qt5 libdbusmenu-glib appmenu-gtk-module latte-dock pipewire pipewire-pulse pipewire-jack pipewire-alsa firewalld
# systemctl enable sddm.service firewalld.service

## Virtualisation using qemu and libvirt
# pacman -S --needed --noconfirm qemu libvirt iptables-nft virt-manager virsh virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs
# systemctl enable libvirtd.service
# usermod -aG libvirt $USERNAME

## For VirtualBox
# pacman -S --needed --noconfirm virtualbox-guest-utils xf86-video-vmware
# systemctl enable vboxservice.service

## For VMware
# pacman -S --needed --noconfirm open-vm-tools gtkmm3 xf86-video-vmware
# systemctl enable vmtoolsd.service vmware-vmblock-fuse.service

## For Hyper-V
# pacman -S --needed --noconfirm hyperv xf86-video-fbdev
# systemctl enable hv_fcopy_daemon.service hv_kvp_daemon.service hv_vss_daemon.service

echo "Install complete, please wait 5 seconds for the computer to reboot."
echo "Please log into $USERNAME once the computer reboots."
sleep 5
reboot
