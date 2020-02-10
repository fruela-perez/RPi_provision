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
echo Instalando Mate Desktop, network manager fix...
echo
sudo apt-get install -y network-manager network-manager-gnome openvpn openvpn-systemd-resolved \
network-manager-openvpn network-manager-openvpn-gnome
sudo apt purge openresolv dhcpcd5
sudo ln -sf /lib/systemd/resolv.conf /etc/resolv.conf


# Fix Policy Kit for applications that need elevated privileges

sudo echo "[Configuration]" >> /etc/polkit-1/localauthority.conf.d/60-desktop-policy.conf
sudo echo "AdminIdentities=unix-user:pi;unix-user:0" >> /etc/polkit-1/localauthority.conf.d/60-desktop-policy.conf
