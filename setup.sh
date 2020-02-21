#!/bin/bash

clear

source settings.sh

echo "+-------------------------+"
echo "|        .profile         |"
echo "+-------------------------+"
echo
echo "Generando nuevo .profile en /etc/skel..."
echo
sudo rm /etc/skel/.profile
sudo cp $BASEDIR/files/profile /etc/skel/.profile
echo
echo "Para eliminar mensaje GNU licence and 'no warranty' al logearse por ssh..."
sudo touch /etc/skel/.hushlogin
echo
echo "Generando .profile para el usuario root..."
sudo cp $BASEDIR/files/root_profile /root/.profile

echo "+-------------------------+"
echo "|   Crear nuevo usuario   |"
echo "+-------------------------+"
echo
echo "Creando usuario $NEW_USER"
echo
source $BASEDIR/create_user.sh $NEW_USER $NEW_USER_PWD sudoer

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

source $BASEDIR/install_basic_stuff.sh
source $BASEDIR/install_ssh.sh
source $BASEDIR/install_apache.sh
source $BASEDIR/install_mariadb.sh
source $BASEDIR/install_php.sh
source $BASEDIR/install_ftp.sh
source $BASEDIR/install_golang.sh
source $BASEDIR/install_geth.sh
source $BASEDIR/install_nodejs_mongodb.sh
source $BASEDIR/install_lets_encrypt_cert.sh
source $BASEDIR/install_textpattern.sh
source $BASEDIR/install_GoAccess.sh
source $BASEDIR/install_Pi4j.sh
source $BASEDIR/install_mate_desktop.sh

echo
echo "+-------------------------+"
echo "|    Vaciar caché APT     |"
echo "+-------------------------+"
echo

sudo du -sh /var/cache/apt

sudo apt-get -y autoremove && sudo apt-get clean

sudo du -sh /var/cache/apt

source $BASEDIR/install_safe_shutdown.sh
