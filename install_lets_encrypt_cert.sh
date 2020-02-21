#!/bin/bash

echo "+-------------------------+"
echo "|      Let’s Encrypt      |"
echo "+-------------------------+"
echo
echo -n "Crear e instalar certificado https? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Creando e instalando certificado...


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

	sudo apt-get install -y $RECOMENDADOS $SUGERIDOS python-certbot-apache
	sudo apt-get install -y $RECOMENDADOS $SUGERIDOS certbot
	sudo certbot --apache
else
    echo Omitiendo la instalación del certificado
fi

