#!/bin/sh
# 8. Set the time zone
ln -sf /usr/share/zoneinfo/Atlantic/Reykjavik /etc/localtime
hwclock --systohc

# 9. Localization
echo "en_us.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
# TODO: Set LANG variable in locale.conf accordingly

# 10. Set root passwond
passwd

# 11. Boot loader
refind-install

# -- RICE --
# Install yay from the AUR
git clone --bare https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg --noconfirm -si

# -- Development --
pacman -S --noconfirm --needed python clang cmake rustup rust-racer
rustup install nightly
rustup default nightly
rustup component add rls-preview
rustup component add rustfmt-preview

# -- Graphical environment --
pacman -S --noconfirm --needed xorg xorg-xinit i3-gaps i3blocks arc-gtk-theme dmenu feh acpi
yay -Sa --noconfirm i3lock-color paper-icon-theme-git

# -- Fonts --
pacman -S --noconfirm --needed ttf-ubuntu-font-family ttf-computer-modern-fonts ttf-dejavu ttf-fira-code ttf-fira-sans ttf-font-awesome ttf-droid ttf-roboto noto-fonts
pacman -S --noconfirm --needed adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts noto-fonts-cjk adobe-source-han-sans-jp-fonts noto-fonts-emoji ttf-freefont ttf-arphic-uming ttf-indic-otf
yay -Sa --noconfirm powerline-fonts-git ttf-ms-fonts ttf-mac-fonts ttf-monapo

# -- Essential programs --
pacman -S --noconfirm --needed alacritty
