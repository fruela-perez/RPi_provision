#!/bin/bash

echo "+-------------------------+"
echo "|         GOLANG          |"
echo "+-------------------------+"
echo
echo -n "Instalar Go? [s/N] "
read respuesta

SETTINGS=$(readlink -f $(dirname $0))/settings.sh
source $SETTINGS

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	cd 
	wget https://dl.google.com/go/go$GO_VERSION.linux-armv6l.tar.gz
	sudo tar -C /usr/local -xzf go$GO_VERSION.linux-armv6l.tar.gz
	rm go$GO_VERSION.linux-armv6l.tar.gz

	echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
	echo "GOPATH=$HOME/golang" >> ~/.profile
	echo "GOROOT=$HOME/golang" >> ~/.profile

	source ~/.profile

	which go
	go version
else
    echo Omitiendo la instalación de Go
fi