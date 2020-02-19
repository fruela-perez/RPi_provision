#!/bin/bash

SHELL=/bin/bash

echo "+-------------------------+"
echo "|        FTP Server       |"
echo "+-------------------------+"
echo
echo -n "¿Instalar servidor FTP? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando servidor FTP...
    echo
	
	echo -n "¿Instalar paquetes sugeridos? [s/N] "
	read psugeridos

	if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
		SUGERIDOS="-o APT::Install-Suggests=1"
	else
		SUGERIDOS="-o APT::Install-Suggests=0"
	fi

    echo
	echo -n "¿Instalar paquetes recomendados? [s/N] "
	read precomendados

	if [ "$precomendados" = "${respuesta#[Ss]}" ] ;then
		RECOMENDADOS="-o APT::Install-Recommends=1"
	else
		RECOMENDADOS="-o APT::Install-Recommends=0"
	fi

	sudo apt-get install -y $RECOMENDADOS $SUGERIDOS vsftpd
	sudo cp files/vsftpd.conf /etc/vsftpd.conf
	sudo service vsftpd restart
else
    echo Omitiendo la instalación del servidor FTP
fi