#!/bin/sh
# vim: cc=
# -- Pre-Installation --
timedatectl set-ntp true

pacman -S --noconfirm --needed dialog || (echo "Are you sure you have an internet connection?" && exit)

# -- Installation --
# 5. Install the base packages
pacman -Sy
pacstrap -i /mnt $(pacman -Sqg base | sed 's/^linux$/&-zen/' | sed 's/^vi$/neovim/' | sed 's/^bash$/zsh/' | sed '/^nano$/d') base-devel git dialog zsh-completions zsh-autosuggestions

# -- Configure the system --
# Enable multilib repository in pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /mnt/etc/pacman.conf

# 6. Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Specify hostname
echo "$(dialog --no-cancel --inputbox "Specify hostname:" 10 100 --output-fd 1)" > /mnt/etc/hostname

# - CHROOT commands -
curl -o /mnt/tmp/chroot.sh https://raw.githubusercontent.com/ArniDagur/arch-install/master/chroot.sh && arch-chroot /mnt bash /tmp/chroot.sh && rm /mnt/tmp/chroot.sh
