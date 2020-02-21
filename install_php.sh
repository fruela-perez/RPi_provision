#!/bin/bash

echo "+-------------------------+"
echo "|           PHP           |"
echo "+-------------------------+"
echo
echo -n "¿Instalar PHP? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando PHP...
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

	sudo apt-get install -y $RECOMENDADOS $SUGERIDOS php php-common \
	php-cli php-fpm php-json php7.3-common \
	php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear \
	php-bcmath php7.3-mysql libapache2-mod-php composer

	sudo service apache2 restart
else
    echo Omitiendo la instalación de PHP
fi