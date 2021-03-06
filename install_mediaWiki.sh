#!/bin/bash

SETTINGS=$(readlink -f $(dirname $0))/settings.sh

echo "+-------------------------+"
echo "|        MEDIAWIKI        |"
echo "+-------------------------+"
echo
echo -n "Instalar MediaWiki $MEDIAWIKI_VERSION? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

	if [ -z $MEDIAWIKI_VERSION ] ;then
		source $SETTINGS
	fi

	cd
	wget https://releases.wikimedia.org/mediawiki/1.34/mediawiki-$MEDIAWIKI_VERSION.tar.gz
	tar -xvf mediawiki-$MEDIAWIKI_VERSION.tar.gz
	rm mediawiki-$MEDIAWIKI_VERSION.tar.gz*
	sudo mv mediawiki-$MEDIAWIKI_VERSION $MEDIAWIKI_DESTINO 
else
    echo Omitiendo la instalación de MediaWiki
fi
