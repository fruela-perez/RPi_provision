#!/bin/bash

SHELL=/bin/bash

GETH_VERSION=1.9.6-bd059680
GO_VERSION=1.13.7

MYSQL_ROOT_PWD='1234' # Ni se te ocurra usar esto como password xD

NEW_USER='fruela'
NEW_USER_PWD='1234' # Ídem xD

DEBIAN_FRONTEND=noninteractive 

GIT_USER="Fruela Pérez"
GIT_EMAIL=fruela.perez@protonmail.com

BASEDIR=$(dirname $0)

clear

echo "+-------------------------+"
echo "|        .profile         |"
echo "+-------------------------+"
echo
echo "Generando nuevo .profile en /etc/skel..."
echo
sudo rm /etc/skel/.profile
sudo cp profile /etc/skel/.profile
echo
echo "Generando .profile para el usuario root..."
sudo cp root_profile /root/.profile

echo "+-------------------------+"
echo "|   Crear nuevo usuario   |"
echo "+-------------------------+"
echo
echo "Creando usuario $NEW_USER"
echo
bash $BASEDIR/create_user.sh $NEW_USER $NEW_USER_PWD sudoer

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

echo -n "¿Instalar paquetes sugeridos? [s/N] "
read psugeridos

if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
	SUGERIDOS="--install-suggests"
else
	SUGERIDOS=""
fi

sudo apt-get install -y --no-install-recommends $SUGERIDOS vim 
sudo apt-get install -y --no-install-recommends $SUGERIDOS git
sudo apt-get install -y --no-install-recommends $SUGERIDOS htop
sudo apt-get install -y --no-install-recommends $SUGERIDOS gnupg
# sudo apt-get install -y $SUGERIDOS debconf

echo
echo "Configurar GIT"
echo
git config --global user.name $GIT_USER
git config --global user.email $GIT_EMAIL
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

	echo -n "¿Instalar paquetes sugeridos? [s/N] "
	read psugeridos

	if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
		SUGERIDOS="--install-suggests"
	else
		SUGERIDOS=""
	fi

	sudo apt-get install -y --no-install-recommends $SUGERIDOS dirmngr apache2
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
	echo -n "¿Instalar paquetes sugeridos? [s/N] "
	read psugeridos

	if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
		SUGERIDOS="--install-suggests"
	else
		SUGERIDOS=""
	fi

    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $PASSWORD"
    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $PASSWORD" 
    
    sudo apt-get install -y --no-install-recommends $SUGERIDOS mariadb-server mariadb-client python-mysqldb
    sudo apt-get install -y --no-install-recommends $SUGERIDOS mariadb-server-10.0
    sudo mysql_secure_installation
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
	echo -n "¿Instalar paquetes sugeridos? [s/N] "
	read psugeridos

	if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
		SUGERIDOS="--install-suggests"
	else
		SUGERIDOS=""
	fi
	sudo apt-get install -y --no-install-recommends $SUGERIDOS php php-common php-cli php-fpm php-json php7.3-common \
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
	echo -n "¿Instalar paquetes sugeridos? [s/N] "
	read psugeridos

	if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
		SUGERIDOS="--install-suggests"
	else
		SUGERIDOS=""
	fi    
	sudo apt-get install -y --no-install-recommends $SUGERIDOS vsftpd
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
echo
if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

	echo -n "¿Instalar paquetes sugeridos para nodejs? [s/N] "
	read psugeridos

	if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
		SUGERIDOS="--install-suggests"
	else
		SUGERIDOS=""
	fi

	sudo apt-get install -y --no-install-recommends $SUGERIDOS npm nodejs
else
    echo Omitiendo la instalación de nodejs
fi

echo
echo -n "Instalar mongodb? [s/N] "
read respuesta  

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

	echo -n "¿Instalar paquetes sugeridos? [s/N] "
	read psugeridos

	if [ "$psugeridos" = "${respuesta#[Ss]}" ] ;then
		SUGERIDOS="--install-suggests"
	else
		SUGERIDOS=""
	fi	
	sudo apt-get install -y --no-install-recommends $SUGERIDOS mongodb-server
else
    echo Omitiendo la instalación de nodejs
fi

# +-------------------------+"
# |      Let’s Encrypt      |"
# +-------------------------+"

bash $BASEDIR/lets_encrypt.sh

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
