#!/bin/bash

echo "+-------------------------+"
echo "| GoAccess - Apache Stats |"
echo "+-------------------------+"
echo
echo -n "¿Instalar GoAccess? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando GoAccess...
    echo
    sudo apt-get update && sudo apt-get install -y libgeoip-dev libncursesw5-dev

    cd
    wget https://tar.goaccess.io/goaccess-$GOACCESS_VERSION.tar.gz
    tar -xzvf goaccess-$GOACCESS_VERSION.tar.gz
    rm goaccess-$GOACCESS_VERSION.tar.gz

    cd goaccess-$GOACCESS_VERSION/
    ./configure --enable-utf8 --enable-geoip=legacy
    make
    sudo make install
else
    echo Omitiendo la instalación.
fi
