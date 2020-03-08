#!/bin/bash

echo "+-------------------------+"
echo "|  Instalar  Textpattern  |"
echo "+-------------------------+"
echo

echo -n "¿Instalar Textpattern? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

	if [ -z $TEXTPATTERN_VERSION ] ;then
		source $(dirname $0)/settings.sh
	fi
	
	cd

	sudo apt-get install -y gtkhash

	wget $TEXTPATTERN_BASE_URL/textpattern-$TEXTPATTERN_VERSION.zip

	sha256file=$(sha256sum textpattern-$TEXTPATTERN_VERSION.zip | cut -b 1-65) 

	if [ $sha256file = $TEXTPATTERN_CHECKSUM ] ;then
		unzip textpattern-$TEXTPATTERN_VERSION.zip
		rm textpattern-$TEXTPATTERN_VERSION.zip

		mysql -u root -p$MYSQL_ROOT_PWD < $(dirname $0)/create_textpattern_database.sql	
	else
		echo "Ha fallado la comprobación de la integridad de textpattern-$TEXTPATTERN_VERSION.zip :("
		echo "Abortando."
	fi

else
    echo Omitiendo la instalación de Textpattern
fi



