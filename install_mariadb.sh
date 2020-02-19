#!/bin/bash

SHELL=/bin/bash

MYSQL_ROOT_PWD='1234' # Ni se te ocurra usar esto como password xD

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
        SUGERIDOS="-o APT::Install-Suggests=1"
    else
        SUGERIDOS="-o APT::Install-Suggests=0"
    fi

    echo
    echo -n "¿Instalar paquetes recomendados? [s/N] "
    read precomendados

    if [ "$precomendados" = "${respuesta#[Ss]}" ] ;then
        RECOMENDADOS="-o APT::Install-Recommends=1"
    else
        RECOMENDADOS="-o APT::Install-Recommends=0"
    fi

    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $PASSWORD"
    sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $PASSWORD" 
    
    sudo apt-get install -y $RECOMENDADOS $SUGERIDOS mariadb-server mariadb-client python-mysqldb
    sudo mysql_secure_installation

    echo "+-------------------------+"
    echo "|        PhpMyAdmin       |"
    echo "+-------------------------+"
    echo
    echo -n "¿Instalar PhpMyAdmin? [s/N] "
    read respuesta

    if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

        VERSION=4.9.4

        wget https://files.phpmyadmin.net/phpMyAdmin/$VERSION/phpMyAdmin-$VERSION-all-languages.tar.gz
        sudo tar zxvf phpMyAdmin-$VERSION-all-languages.tar.gz -C /var/www/html
        rm phpMyAdmin-$VERSION-all-languages.tar.gz
        sudo ln -s /var/www/html/phpMyAdmin-$VERSION-all-languages/ /var/www/html/phpMyAdmin
        
        sed -i "s/define('TEMP_DIR', '.\/tmp\/');/define('TEMP_DIR', '\/tmp\/');/g" vendor_config.php
        sed -i "s/define('CONFIG_DIR', '');/define('CONFIG_DIR', '\/etc\/phpmyadmin\/');/g" vendor_config.php

        sudo service apache2 restart
    else 
        echo Omitiendo la instalación de PhpMyAdmin
    fi

else 
    echo Omitiendo la instalación de MariaDB
fi



