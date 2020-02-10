#!/bin/bash

SHELL=/bin/bash

GETH_VERSION=1.9.6-bd059680
GO_VERSION=1.13.7

MYSQL_ROOT_PWD='1234' # Ni se te ocurra usar esto como password xD
DEBIAN_FRONTEND=noninteractive 

clear

# echo "+-------------------------+"
# echo "| Retroflag Safe shutdown |"
# echo "+-------------------------+"
# echo
# echo "¿Instalar script? [y/N]"
# read respuesta

# if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
#     echo Instalando...
#     echo
# 	wget -O - "https://raw.githubusercontent.com/RetroFlag/retroflag-picase/master/install.sh" | sudo bash
# else
#     echo Omitiendo la instalación
# fi

echo "+-------------------------+"
echo "|        .profile         |"
echo "+-------------------------+"
echo
echo "Generando .profile para el usuario pi..."
echo
cp profile ~/.profile
echo
echo "Generando .profile para el usuario root..."
sudo cp root_profile /root/.profile

echo
echo "+-------------------------+"
echo "|    Actualizar sistema   |"
echo "+-------------------------+"
echo
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y autoremove

echo
echo "+-------------------------+"
echo "|   Actualizar firmware   |"
echo "+-------------------------+"
echo
echo "¿Actualizar firmware? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Actualizando firmware...
    echo
    sudo rpi-update
else
    echo Omitiendo la actualización del firmware de la RPi
fi
echo
echo "+-------------------------+"
echo "|      Basic cosillas     |"
echo "+-------------------------+"
echo
sudo apt-get install -y vim ctags vim-doc vim-scripts
sudo apt-get install -y git
sudo apt-get install -y htop
sudo apt-get install -y gnupg
sudo apt-get install -y debconf

echo
echo "+-------------------------+"
echo "|           SSH           |"
echo "+-------------------------+"
echo
echo "¿Instalar servidor SSH? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Instalando servidor SSH...
    echo
	sudo systemctl enable ssh
	sudo systemctl start ssh
else
    echo Omitiendo la instalación del servidor SSH
fi

echo
echo "+-------------------------+"
echo "|          APACHE         |"
echo "+-------------------------+"
echo
echo "¿Instalar Apache? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Instalando Apache...
    echo
	sudo apt-get install -y dirmngr apache2
else
    echo Omitiendo la instalación de Apache
fi
echo
echo "+-------------------------+"
echo "|         MariaDB         |"
echo "+-------------------------+"
echo
echo "¿Instalar MariaDB? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Instalando MariaDB...
    echo	
    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $PASSWORD"
    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $PASSWORD" 
    
    sudo apt-get install -y mariadb-server mariadb-client python-mysqldb
    sudo apt-get install -y mariadb-server-10.0
    #sudo mysql_secure_installation
else 
    echo Omitiendo la instalación de MariaDB
fi

echo
echo "+-------------------------+"
echo "|           PHP           |"
echo "+-------------------------+"
echo
echo "¿Instalar PHP? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
    echo Instalando PHP...
    echo
	sudo apt-get install -y php php-common php-cli php-fpm php-json php7.3-common \
	php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear \
	php-bcmath php7.3-mysql libapache2-mod-php

	sudo service apache2 restart
else
    echo Omitiendo la instalación de PHP
fi

echo
echo "+-------------------------+"
echo "|           FTP           |"
echo "+-------------------------+"
echo
echo "¿Instalar servidor FTP? [y/N]"
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

echo
echo "+-------------------------+"
echo "|         GOLANG          |"
echo "+-------------------------+"
echo
echo "Instalar Go? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
	cd 
	wget https://dl.google.com/go/go$GO_VERSION.linux-armv6l.tar.gz
	sudo tar -C /usr/local -xzf go$GO_VERSION.linux-armv6l.tar.gz
	rm go$GO_VERSION.linux-armv6l.tar.gz

	echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
	echo "GOPATH=$HOME/golang" >> ~/.profile

	source ~/.profile

	which go
	go version
else
    echo Omitiendo la instalación de Go
fi

echo
echo "+-------------------------+"
echo "|           GETH          |"
echo "+-------------------------+"
echo
echo "Instalar Geth? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
	cd 
	wget https://gethstore.blob.core.windows.net/builds/geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo tar -xvf geth-linux-arm7-$GETH_VERSION.tar.gz
	cd geth-linux-arm7-$GETH_VERSION
	sudo mv geth /u sr/local/bin/
	cd
	rm geth-linux-arm7-$GETH_VERSION.tar.gz
else
    echo Omitiendo la instalación de Geth
fi

echo
echo "+-------------------------+"
echo "|    nodejs y mongodb     |"
echo "+-------------------------+"
echo
echo "Instalar nodejs? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
	sudo apt-get install -y nodejs
else
    echo Omitiendo la instalación de nodejs
fi

echo
echo "Instalar mongodb? [y/N]"
read respuesta

if [ "$respuesta" != "${respuesta#[Yy]}" ] ;then
	sudo apt-get install -y mongodb-server
else
    echo Omitiendo la instalación de nodejs
fi

echo
echo "+-------------------------+"
echo "|      Let’s Encrypt      |"
echo "+-------------------------+"
echo
echo "Crear e instalar certificado https? [y/N]"
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

echo
echo "Misión cumplida! :)"
