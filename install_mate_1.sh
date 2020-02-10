#!/bin/bash

echo Instalando Mate Desktop, paquetes básicos...
echo
sudo apt-get install -y xorg lightdm lightdm-gtk-greeter mate-desktop-environment \
blueman network-manager-gnome pulseaudio pulseaudio-module-bluetooth pavucontrol \
bluez-firmware pi-package rc-gui mate-tweak lightdm-gtk-greeter-settings samba menulibre
echo
echo Instalando Mate Desktop, paquetes adicionales...
echo
sudo apt-get install -y vlc kodi wireshark remmina ttf-mscorefonts-installer fonts-ubuntu \
human-icon-theme xrdp gparted mate-desktop-environment-extras arc-theme numix-gtk-theme
echo
echo Instalando apps útiles...
echo
sudo apt-get install -y eom gufw gksu mozo mate-tweak engrampa galculator gucharmap \
mate-utils mate-power-manager mate-system-monitor mate-screensaver
echo
echo Instalando Mate Desktop, network manager fix...
echo
sudo apt-get install -y network-manager network-manager-gnome openvpn openvpn-systemd-resolved \
network-manager-openvpn network-manager-openvpn-gnome
echo
echo Configurando cosas...
echo
sudo apt purge openresolv dhcpcd5
sudo ln -sf /lib/systemd/resolv.conf /etc/resolv.conf

sudo reboot
