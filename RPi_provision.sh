#!/bin/bash

echo "+-------------------------+"
echo "|    Actualizar sistema   |"
echo "+-------------------------+"

sudo apt update
sudo apt upgrade

echo "+-------------------------+"
echo "|   Actualizar firmware   |"
echo "+-------------------------+"

echo "¿Actualizar firmware? (y/n) \c"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Actualizando firmware...
    echo
    sudo rpi-update
else
    echo Omitiendo la actualización del firmware de la RPi
fi

echo "+-------------------------+"
echo "|      Basic cosillas     |"
echo "+-------------------------+"

sudo apt-get install -y vim ctags vim-doc vim-scripts
sudo apt-get install -y git
sudo apt-get install -y htop

echo "+-------------------------+"
echo "|           SSH           |"
echo "+-------------------------+"

echo "¿Instalar servidor SSH? (y/n) \c"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Instalando servidor SSH...
    echo
	sudo systemctl enable ssh
	sudo systemctl start sshelse
else
    echo Omitiendo la instalación del servidor SSH
fi

echo "+-------------------------+"
echo "|           FTP           |"
echo "+-------------------------+"

echo "¿Instalar servidor FTP? (y/n) \c"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Instalando servidor FTP...
    echo
	sudo apt-get install -y vsftpd
	sudo cp vsftpd.conf /etc/vsftpd.conf
	sudo service vsftpd restart
else
    echo Omitiendo la instalación del servidor FTP
fi

echo "+-------------------------+"
echo "|      Let’s Encrypt      |"
echo "+-------------------------+"

echo "Crear e instalar certificado https? (y/n) \c"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Creando e instalando certificado...
    echo
	sudo apt-get install -y python-certbot-apache
	sudo apt-get install certbot
	sudo certbot --apache
else
    echo Omitiendo la instalación del certificado
fi


echo "+-------------------------+"
echo "|         .profile        |"
echo "+-------------------------+"

cp profile ~/.profile

echo "+-------------------------+"
echo "|         GOLANG          |"
echo "+-------------------------+"

echo "Instalar Go? (y/n) \c"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
	cd 
	wget https://dl.google.com/go/go1.13.7.linux-armv6l.tar.gz
	sudo tar -C /usr/local -xzf go1.13.7.linux-armv6l.tar.gz
	rm go1.13.7.linux-armv6l.tar.gz

	echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
	echo "GOPATH=$HOME/golang" >> ~/.profile

	source ~/.profile

	which go
	go version
else
    echo Omitiendo la instalación de Go
fi

echo "+-------------------------+"
echo "|           GETH          |"
echo "+-------------------------+"

# sudo apt-get -y install dphys-swapfile build-essential libgmp3-dev curl
# cd 
# git clone https://github.com/ethereum/go-ethereum
# cd go-ethereum
# sudo make geth


GETH_VERSION=1.9.6-bd059680

echo "Instalar Geth? (y/n) \c"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
	cd 
	wget https://gethstore.blob.core.windows.net/builds/geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo tar -xvf geth-linux-arm7-$GETH_VERSION.tar.gz
	cd geth-linux-arm7-$GETH_VERSION
	sudo mv geth /usr/local/bin/
	cd
	rm geth-linux-arm7-$GETH_VERSION.tar.gz
else
    echo Omitiendo la instalación de Geth
fi

