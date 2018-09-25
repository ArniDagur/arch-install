#!/bin/sh
# vim: cc=

pacman -S --noconfirm --needed dialog || (echo "Are you sure you have an internet connection?" && exit)

# -- Pre-Installation
# 1. Update the system clock
timedatectl set-ntp true

# 2. Partition the disks
disk="$(dialog --no-cancel --inputbox "$(lsblk)\n\nWhat is your disk called?\n    Example: /dev/sda" 10 100 --output-fd 1)"

cat <<EOF | gdisk $disk
o
y
n
1

+512MB
EF00
n
2



w
y
EOF
# Partition /dev/sdb if exists
cat <<EOF | gdisk /dev/sdb
o
y
n
1



w
y
EOF

# 3. Format the partitions
rootpart="$(dialog --no-cancel --inputbox "$(lsblk)\n\nWhat is your root partition called?\n    Example: /dev/sda2" 10 100 --output-fd 1)"
bootpart="$(dialog --no-cancel --inputbox "$(lsblk)\n\nWhat is your boot partition called?\n    Example: /dev/sda1" 10 100 --output-fd 1)"

mkfs.vfat $bootpart
mkfs.ext4 $rootpart
mkfs.ext4 /dev/sdb1

# 4. Mount the file systems
mount $rootpart /mnt
mkdir /mnt/boot
mount $bootpart /mnt/boot
mkdir /mnt/sdb
mount /dev/sdb1 /mnt/sdb || rmdir /mnt/sdb

# -- Installation --
# 5. Install the base packages
pacstrap -i /mnt base base-devel refind-efi neovim git --ignore nano,vi

# -- Configure the system --
# 6. Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Specify hostname
echo "$(dialog --no-calcel --inputbox "Specify hostname:" 10 100 --output-fd 1)" > /mnt/etc/hostname

# - CHROOT commands -
curl https://raw.githubusercontent.com/ArniDagur/arch-install/master/chroot.sh > /mnt/chroot.sh && arch-chroot /mnt bash chroot.sh && rm /mnt/chroot.sh
