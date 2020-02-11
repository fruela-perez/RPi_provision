#!/bin/bash

SHELL=/bin/bash

export GETH_VERSION=1.9.6-bd059680
GO_VERSION=1.13.7

MYSQL_ROOT_PWD='1234' # Ni se te ocurra usar esto como password xD

NEW_USER='fruela'
NEW_USER_PWD='1234' # Ídem xD

DEBIAN_FRONTEND=noninteractive 

clear

echo "Creando usuario $NEW_USER"
echo
./create_user.sh $NEW_USER $NEW_USER_PWD sudoer

echo
echo "+-------------------------+"
echo "|        .profile         |"
echo "+-------------------------+"
echo
echo "Generando .profile para nuevo usuario..."
echo
cp profile /home/$NEW_USER/.profile
source ~/.profile
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
echo -n "¿Actualizar firmware? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
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
sudo apt-get install -y --install-suggests vim 
sudo apt-get install -y --install-suggests git
sudo apt-get install -y --install-suggests htop
sudo apt-get install -y --install-suggests gnupg
sudo apt-get install -y --install-suggests debconf

echo
echo "Configurar GIT"
echo
git config --global user.name "Fruela Pérez"
git config --global user.email fruela.perez@protonmail.com
git config --global core.editor vim

echo
echo "+-------------------------+"
echo "|           SSH           |"
echo "+-------------------------+"
echo
echo -n "¿Instalar servidor SSH? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
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
echo -n "¿Instalar Apache? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando Apache...
    echo
	sudo apt-get install -y --install-suggests dirmngr apache2
	sudo apt-get -y autoremove
else
    echo Omitiendo la instalación de Apache
fi
echo
echo "+-------------------------+"
echo "|         MariaDB         |"
echo "+-------------------------+"
echo
echo -n "¿Instalar MariaDB? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando MariaDB...
    echo	
    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $PASSWORD"
    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $PASSWORD" 
    
    sudo apt-get install -y --install-suggests mariadb-server mariadb-client python-mysqldb
    sudo apt-get install -y --install-suggests mariadb-server-10.0
    #sudo mysql_secure_installation
else 
    echo Omitiendo la instalación de MariaDB
fi

echo
echo "+-------------------------+"
echo "|           PHP           |"
echo "+-------------------------+"
echo
echo -n "¿Instalar PHP? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando PHP...
    echo
	sudo apt-get install -y --install-suggests php php-common php-cli php-fpm php-json php7.3-common \
	php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear \
	php-bcmath php7.3-mysql libapache2-mod-php composer

	sudo service apache2 restart
else
    echo Omitiendo la instalación de PHP
fi

echo
echo "+-------------------------+"
echo "|           FTP           |"
echo "+-------------------------+"
echo
echo -n "¿Instalar servidor FTP? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando servidor FTP...
    echo
	sudo apt-get install -y --install-suggests vsftpd
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
echo -n "Instalar Go? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
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
echo -n "Instalar Geth? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	cd 
	wget https://gethstore.blob.core.windows.net/builds/geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo tar -xvf geth-linux-arm7-$GETH_VERSION.tar.gz
	cd geth-linux-arm7-$GETH_VERSION
	sudo mv geth /usr/local/bin/
	cd
	rm geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo rm -rf geth-linux-arm7-$GETH_VERSION
else
    echo Omitiendo la instalación de Geth
fi

echo
echo "+-------------------------+"
echo "|    nodejs y mongodb     |"
echo "+-------------------------+"
echo
echo -n "Instalar nodejs? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	sudo apt-get install -y --install-suggests nodejs
else
    echo Omitiendo la instalación de nodejs
fi

echo
echo -n "Instalar mongodb? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	sudo apt-get install -y --install-suggests mongodb-server
else
    echo Omitiendo la instalación de nodejs
fi

echo
echo "+-------------------------+"
echo "|      Let’s Encrypt      |"
echo "+-------------------------+"
echo
echo -n "Crear e instalar certificado https? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Creando e instalando certificado...
    echo
	sudo apt-get install -y --install-suggests python-certbot-apache
	sudo apt-get install certbot
	sudo certbot --apache
else
    echo Omitiendo la instalación del certificado
fi

echo "+-------------------------+"
echo "| Retroflag Safe shutdown |"
echo "+-------------------------+"
echo
echo -n "¿Instalar script? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando...
    echo
	wget -O - "https://raw.githubusercontent.com/RetroFlag/retroflag-picase/master/install.sh" | sudo bash
else
    echo Omitiendo la instalación
fi

sudo apt-get -y autoremove
echo
echo "Misión cumplida! :)"
