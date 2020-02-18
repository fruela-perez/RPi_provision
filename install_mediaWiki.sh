#!/bin/bash

VERSION='1.34.0'
DESTINO='/var/www/html/mediawiki'

echo "+-------------------------+"
echo "|        MEDIAWIKI        |"
echo "+-------------------------+"
echo
echo -n "Instalar MediaWiki $VERSION? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	cd
	wget https://releases.wikimedia.org/mediawiki/1.34/mediawiki-$VERSION.tar.gz
	tar -xvf mediawiki-$VERSION.tar.gz
	rm mediawiki-$VERSION.tar.gz*
	mv mediawiki-$VERSION $DESTINO 
else
    echo Omitiendo la instalación de MediaWiki
fi
