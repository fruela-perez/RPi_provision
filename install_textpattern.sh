#!/bin/bash

SHELL=/bin/bash
BASEDIR=$(dirname $0)
VERSION=4.7.3
CHECKSUM="3093e50c51e868a6f2301230a7853d70691b6a521f41adeab22da461d00404cc"

echo "+-------------------------+"
echo "|  Instalar  Textpattern  |"
echo "+-------------------------+"
echo
cd

sudo apt install -y gtkhash


# export VERSION=4.7.3
# export CHECKSUM="3093e50c51e868a6f2301230a7853d70691b6a521f41adeab22da461d00404cc"
# export sha256file=$(sha256sum textpattern-$VERSION.zip) 

wget https://textpattern.com/File+download/91/textpattern-$VERSION.zip

sha256file=$(sha256sum textpattern-$VERSION.zip | cut -b 1-65) 

if [ $sha256file = $CHECKSUM ] ;then
	unzip textpattern-$VERSION.zip
	rm textpattern-$VERSION.zip

	mysql -u root -p1234 < create_textpattern_database.sql	
else
	echo "Ha fallado la comprobación de la integridad de textpattern-$VERSION.zip :("
	echo "Abortando."
fi

