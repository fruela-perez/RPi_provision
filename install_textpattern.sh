#!/bin/bash

echo "+-------------------------+"
echo "|  Instalar  Textpattern  |"
echo "+-------------------------+"
echo
cd

sudo apt-get install -y gtkhash

wget https://textpattern.com/File+download/91/textpattern-$TEXTPATTERNS_VERSION.zip

sha256file=$(sha256sum textpattern-$VERSION.zip | cut -b 1-65) 

if [ $sha256file = $TEXTPATTERNS_CHECKSUM ] ;then
	unzip textpattern-$TEXTPATTERNS_VERSION.zip
	rm textpattern-$TEXTPATTERNS_VERSION.zip

	mysql -u root -p$MYSQL_ROOT_PWD < create_textpattern_database.sql	
else
	echo "Ha fallado la comprobación de la integridad de textpattern-$TEXTPATTERNS_VERSION.zip :("
	echo "Abortando."
fi

