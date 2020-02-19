#!/bin/bash

SHELL=/bin/bash

# Instalar Mate Desktop

echo "+-------------------------+"
echo "|       Mate Desktop      |"
echo "+-------------------------+"
echo
echo -n "¿Instalar Mate Desktop? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando...
    echo
	echo "+--------------------------------------------+"
	echo "| Instalando Mate Desktop: paquetes básicos. |"
	echo "+--------------------------------------------+"
	echo
	sudo apt-get install -y -o APT::Install-Recommends=0 -o APT::Install-Suggests=0 \
	     xorg lightdm lightdm-gtk-greeter mate-desktop-environment blueman \
	     network-manager-gnome pulseaudio pulseaudio-module-bluetooth pavucontrol \
		   bluez-firmware pi-package rc-gui mate-tweak lightdm-gtk-greeter-settings \
		   samba menulibre
	echo
	echo "+------------------------------------------------+"
	echo "| Instalando Mate Desktop: paquetes adicionales. |"
	echo "+------------------------------------------------+"
	echo
	sudo apt-get install -y -o APT::Install-Recommends=0 -o APT::Install-Suggests=0 \
	     vlc kodi wireshark remmina ttf-mscorefonts-installer fonts-ubuntu \
	     human-icon-theme xrdp gparted mate-desktop-environment-extras arc-theme numix-gtk-theme
	echo
	echo "+-------------------------+"
	echo "| Instalando apps útiles. |"
	echo "+-------------------------+"
	echo
	sudo apt-get install -y -o APT::Install-Recommends=0 -o APT::Install-Suggests=0 \
	     eom gufw gksu mozo mate-tweak engrampa galculator gucharmap \
	     mate-utils mate-power-manager mate-system-monitor mate-screensaver
	echo
	echo "+-----------------------------------------------+"
	echo "| Instalando Mate Desktop: network manager fix. |"
	echo "+-----------------------------------------------+"
	echo
	sudo apt-get install -y -o APT::Install-Recommends=0 -o APT::Install-Suggests=0 \
	     network-manager network-manager-gnome openvpn openvpn-systemd-resolved \
	     network-manager-openvpn network-manager-openvpn-gnome
	echo
	echo Configurando cosas...
	echo
	sudo apt purge openresolv dhcpcd5
	sudo ln -sf /lib/systemd/resolv.conf /etc/resolv.conf

	# Fix Policy Kit for applications that need elevated privileges

	sudo echo "[Configuration]" >> /etc/polkit-1/localauthority.conf.d/60-desktop-policy.conf
	sudo echo "AdminIdentities=unix-user:pi;unix-user:0" >> /etc/polkit-1/localauthority.conf.d/60-desktop-policy.conf

	echo "Es necesario reiniciar. Pulsa la tecla Any..."
	read tecla

	sudo reboot
else
    echo Omitiendo la instalación
fi
