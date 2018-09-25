#!/bin/sh

# Install yay from the AUR
cd /tmp
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xvf yay.tar.gz
cd yay
makepkg --noconfirm -si
cd ..
rm -rf yay yay.tar.gz

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
# GUI
pacman -S --noconfirm --needed alacritty qutebrowser keepassxc
# CLI
pacman -S --noconfirm --needed xclip
# Editors
pacman -S --noconfirm --needed python-neovim emacs
yay -Sa --noconfirm neovim-symlinks
