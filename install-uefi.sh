#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "Arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo "Please type root password"
passwd root

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S --noconfirm --needed doas efibootmgr os-prober grub grub-btrfs networkmanager btrfs-progs network-manager-applet dialog wpa_supplicant dosfstools reflector base-devel linux-headers xdg-user-dirs xdg-utils gvfs gvfs-mtp bluez bluez-utils alsa-utils pulseaudio pulseaudio-bluetooth bash-completion openssh git nano
pacman -S --noconfirm --needed xf86-video-intel
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd

useradd -mG wheel tanveer
passwd tanveer

touch /etc/doas.conf
echo "permit nopass :wheel as root" >> /etc/doas.conf

#echo "Enable users wheel in sudoers file"
#sleep 5
#EDITOR=nano visudo

printf "\e[1;32mDone! Type exit, umount -a and reboot.If u installed system on btrfs FS... considering add btrfs in modules of mkinitcpio file and generate initcpio file\e[0m"




