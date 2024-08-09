#!/bin/bash

# Exit on any error
set -e

echo "Installing dependencies..."
sudo pacman -S --noconfirm base-devel git libx11 libxft xorg-server xorg-xinit terminus-font

echo "Creating directory for source code..."
mkdir -p ~/.local/src

echo "Cloning repositories..."
git clone git://git.suckless.org/st ~/.local/src/st
git clone git://git.suckless.org/dmenu ~/.local/src/dmenu
git clone git://git.suckless.org/dwm ~/.local/src/dwm

echo "Installing st..."
cd ~/.local/src/st
make clean
sudo make install

echo "Configuring and installing dmenu..."
cd ~/.local/src/dmenu
sed -i 's/^XINERAMALIBS/#XINERAMALIBS/' config.mk
sed -i 's/^XINERAMAFLAGS/#XINERAMAFLAGS/' config.mk
make clean
sudo make install

echo "Configuring and installing dwm..."
cd ~/.local/src/dwm
sed -i 's/^XINERAMALIBS/#XINERAMALIBS/' config.mk
sed -i 's/^XINERAMAFLAGS/#XINERAMAFLAGS/' config.mk
make clean
sudo make install

echo "Creating .xinitrc..."
echo "exec dwm" > ~/.xinitrc

echo "Installation complete. You can now start dwm by running 'startx'."
