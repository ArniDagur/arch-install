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
yay -S --repo --noconfirm python clang cmake rustup rust-racer
rustup install nightly
rustup default nightly
rustup component add rls-preview
rustup component add rustfmt-preview
rustup component add crippy-preview
rustup component add rust-src

# -- Graphical environment --
yay -S --repo --noconfirm xorg xorg-xinit i3-gaps i3blocks arc-gtk-theme dmenu feh acpi
yay -Sa --noconfirm i3lock-color paper-icon-theme-git

# -- Fonts --
yay -S --repo --noconfirm ttf-ubuntu-font-family ttf-computer-modern-fonts ttf-dejavu ttf-fira-code ttf-fira-sans ttf-font-awesome ttf-droid ttf-roboto noto-fonts
# Asian
yay -S --repo --noconfirm adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts noto-fonts-cjk adobe-source-han-sans-jp-fonts
# Emoji
yay -S --repo --noconfirm noto-fonts-emoji ttf-freefont ttf-arphic-uming ttf-indic-otf
# Non-powerline monospace
yay -S --repo adobe-source-code-pro-fonts
yay -Sa --noconfirm powerline-fonts-git ttf-ms-fonts ttf-mac-fonts ttf-monapo

# -- Essential programs --
# GUI
yay -S --repo --noconfirm alacritty qutebrowser keepassxc mupdf
# CLI
yay -S --repo --noconfirm xclip
# Editors
yay -S --repo --noconfirm python-neovim emacs
yay -Sa --noconfirm neovim-symlinks
