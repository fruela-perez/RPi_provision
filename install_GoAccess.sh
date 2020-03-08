#!/bin/bash

echo "+-------------------------+"
echo "| GoAccess - Apache Stats |"
echo "+-------------------------+"
echo

SETTINGS=$(readlink -f $(dirname $0))/settings.sh

echo -n "¿Instalar GoAccess? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando GoAccess...
    echo
    sudo apt-get update && sudo apt-get install -y libgeoip-dev libncursesw5-dev

	if [ -z $GOACCESS_VERSION ] ;then
		source $SETTINGS
	fi

    cd
    wget https://tar.goaccess.io/goaccess-$GOACCESS_VERSION.tar.gz
    tar -xzvf goaccess-$GOACCESS_VERSION.tar.gz
    rm goaccess-$GOACCESS_VERSION.tar.gz

    cd goaccess-$GOACCESS_VERSION/
    ./configure --enable-utf8 --enable-geoip=legacy
    make
    sudo make install

	echo -n "¿Instalar scripts para generar informes y crear cron jobs? [s/N] "
	read respuesta

	if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	    echo ToDo.
	else
	    echo Omitiendo el proceso.
	fi

else
    echo Omitiendo la instalación.
fi
