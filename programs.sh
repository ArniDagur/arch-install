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
# Tools
yay -S --repo --noconfirm clang cmake
# Rust
yay -S --repo --noconfirm rustup rust-racer
rustup install nightly
rustup default nightly
rustup component add rls-preview
rustup component add rustfmt-preview
rustup component add clippy-preview
rustup component add rust-src
# Python
yay -S --repo --noconfirm python python-pip python-numpy python-matplotlib python-scipy python-pandas python-

# -- Graphical environment --
yay -S --repo --noconfirm xorg xorg-xinit xorg-apps xclip i3-gaps i3blocks arc-gtk-theme dmenu feh acpi unclutter
yay -S --noconfirm i3lock-color paper-icon-theme-git

# -- Fonts --
# Fonts stolen from other operating systems:
yay -S --noconfirm ttf-ubuntu-font-family ttf-mac-fonts ttf-ms-fonts
# Font for i3blocks
yay -S --noconfirm ttf-font-awesome-4
# Latin fonts
yay -S --noconfirm ttf-dejavu
# Asian
yay -S --noconfirm adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts adobe-source-han-sans-jp-fonts
# Emoji
yay -S --noconfirm noto-fonts-emoji ttf-freefont ttf-arphic-uming ttf-indic-otf
# Monospace fonts
yay -S --noconfirm adobe-source-code-pro-fonts powerline-fonts-git

# -- CLI --
# Compression
yay -S --noconfirm p7zip
# Editors
yay -S --noconfirm python-neovim neovim-symlinks emacs

# -- GUI --
# Terminal emulator
yay -S --noconfirm alacritty
# PDF viewer
yay -S --noconfirm mupdf
# Web browser
yay -S --noconfirm qutebrowser pdfjs
# File explorer
yay -S --noconfirm ranger
# Password manager
yay -S --repo --noconfirm keepassxc
# Social
yay -S --noconfirm discord-ptb

# -- Drivers --
# Install appropriate video drivers
gpu=$(lspci | grep ' VGA ')
if echo $gpu | grep -i 'NVIDIA'; then
    # -- NVIDIA --
    yay -S --repo --noconfirm nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings
    # Pacman hook
    curl https://raw.githubusercontent.com/ArniDagur/arch-install/master/files/nvidia.hook > /etc/pacman.d/hooks/nvidia.hook
    # Mkinitcpio modules for Direct Rendering Manager
    cat <<EOF >> /etc/mkinitcpio.conf

# NVIDIA Direct Rendering Manager:
MODULES += ('nvidia' 'nvidia_modeset' 'nvidia_uvm' 'nvidia_drm')
EOF
fi
if echo $gpu | grep -i 'Intel'; then
    # -- Intel (laptops) --
    yay -S --repo --noconfirm xf86-video-intel mesa lib32-mesa intel-media-driver intel-gpu-tools
fi
# Touchpad and Wacom Tablet drivers
yay -S --repo --noconfirm xf86-input-synaptics xf86-input-wacom

# -- Pacman stuff --
# Sort pacman mirrors
yay -S --noconfirm reflector
curl https://raw.githubusercontent.com/ArniDagur/arch-install/master/files/mirrorupgrade.hook > /etc/pacman.d/hooks/mirrorupgrade.hook
# _NECCESARY_ for makepkg.conf:
yay -S --noconfirm aria2-fast pigz pbzip2
