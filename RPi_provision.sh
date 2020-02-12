#!/bin/bash

SHELL=/bin/bash
DEBIAN_FRONTEND=noninteractive 
BASEDIR=$(dirname $0)

NEW_USER='fruela'
NEW_USER_PWD='1234' # No uses una contraseña así de cutre, porfa ;)

clear

echo "+-------------------------+"
echo "|        .profile         |"
echo "+-------------------------+"
echo
echo "Generando nuevo .profile en /etc/skel..."
echo
sudo rm /etc/skel/.profile
sudo cp $BASEDIR/files/profile /etc/skel/.profile
echo
echo "Generando .profile para el usuario root..."
sudo cp $BASEDIR/files/root_profile /root/.profile

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

bash $BASEDIR/basic_stuff.sh
bash $BASEDIR/install_ssh.sh
bash $BASEDIR/install_apache.sh
bash $BASEDIR/install_mariadb.sh
bash $BASEDIR/install_php.sh
bash $BASEDIR/install_ftp.sh
bash $BASEDIR/install_golang.sh
bash $BASEDIR/install_geth.sh
bash $BASEDIR/install_mean.sh
bash $BASEDIR/lets_encrypt.sh
bash $BASEDIR/textpattern.sh
bash $BASEDIR/install_mate_desktop.sh

sudo apt-get -y autoremove

bash $BASEDIR/install_safe_shutdown.sh
