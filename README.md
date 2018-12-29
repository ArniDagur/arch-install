# Personal Arch Linux installer

Personal Arch installer, suited to my needs exactly. DO NOT USE THIS YOURSELVES!

## Manual steps:

### 0. Partition disks:

This video is helpful for this step: https://www.youtube.com/watch?v=DfC5hgdtbWY

### 1. Format partitions:
For example:
```
echo "y" | mkfs.vfat $bootpart
echo "y" | mkfs.ext4 $rootpart
echo "y" | mkfs.ext4 /dev/sdb1
```

### 2. Mount the file systems
For example:
```
mount $rootpart /mnt
mkdir /mnt/boot
mount $bootpart /mnt/boot
mkdir /mnt/sdb
mount /dev/sdb1 /mnt/sdb
```

## License

This project is licensed under the GNU General Public License v3.0, as the project I based this installer on, [`LukeSmithxyz/LARBS`](https://github.com/LukeSmithxyz/LARBS), is so as well.
