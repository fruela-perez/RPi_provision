#!/bin/bash

echo "+-------------------------+"
echo "|           GETH          |"
echo "+-------------------------+"
echo
echo -n "Instalar Geth? [s/N] "
read respuesta

SETTINGS=$(readlink -f $(dirname $0))/settings.sh

if [ -z $GETH_VERSION ] ;then
	source $SETTINGS
fi

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	cd 
	wget https://gethstore.blob.core.windows.net/builds/geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo tar -xvf geth-linux-arm7-$GETH_VERSION.tar.gz
	cd geth-linux-arm7-$GETH_VERSION
	sudo mv geth /usr/local/bin/
	cd
	rm geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo rm -rf geth-linux-arm7-$GETH_VERSION
	echo
	geth version
else
    echo Omitiendo la instalación de Geth
fi