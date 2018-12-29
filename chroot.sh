#!/bin/sh
# 8. Set the time
ln -sf /usr/share/zoneinfo/Atlantic/Reykjavik /etc/localtime
hwclock --systohc

# 9. Localization
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
# TODO: Set LANG variable in locale.conf accordingly

# 10. Set root passwond
passwd

# 11. Boot loader
rootpart=$(dialog --no-cancel --inputbox "$(lsblk -o NAME,SIZE,TYPE)\n\nEnter name of root partition (e.g. /dev/sda2)" 30 100 --output-fd 1)
partuuid=$(blkid -o value -s PARTUUID $rootpart)
bootctl install

cat >/boot/loader/loader.conf <<EOF
default arch-zen
timeout 3
EOF

# Enable NVIDIA Direct Rendering Manager if this computer has an NVIDIA GPU
if lspci | grep ' VGA ' | grep -i 'NVIDIA'; then
    nvidia_param='nvidia-drm.modeset=1'
fi

cat >/boot/loader/entries/arch-zen.conf <<EOF
title Arch Linux Zen
linux /vmlinuz-linux-zen
initrd /initramfs-linux-zen.img
options root=PARTUUID=$partuuid rw $nvidia_param
EOF

# ---- Post-Install ----
# -- Create user --
name=$(dialog --no-cancel --inputbox "Enter a name for the user account." 10 60 --output-fd 1)
pass1=$(dialog --no-cancel --passwordbox "Enter a password for that user." 10 60 --output-fd 1)
pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 --output-fd 1)

while [ $pass1 != $pass2 ]
do
    pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\n\nEnter password again." 10 60 --output-fd 1)
    pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 --output-fd 1)
    unset pass2
done

dialog --infobox "Adding user \"$name\"..." 4 50
useradd -m -g wheel -s /bin/zsh $name
echo "$name:$pass1" | chpasswd

# -- Install userland programs as user $name --
# Instate sudoers file that allows users in wheel group to issue any command without a password.
curl https://raw.githubusercontent.com/ArniDagur/arch-install/master/files/sudoers_tmp > /etc/sudoers
# Run programs.sh
curl https://raw.githubusercontent.com/ArniDagur/arch-install/master/programs.sh > /tmp/programs.sh && sudo -u $name bash /tmp/programs.sh
# Instate normal sudoers file
curl https://raw.githubusercontent.com/ArniDagur/arch-install/master/files/sudoers > /etc/sudoers
