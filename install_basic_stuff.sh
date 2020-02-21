#!/bin/bash

echo "+-------------------------+"
echo "|      Basic cosillas     |"
echo "+-------------------------+"
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

sudo apt-get install -y $RECOMENDADOS $SUGERIDOS vim 
sudo apt-get install -y $RECOMENDADOS $SUGERIDOS git
sudo apt-get install -y $RECOMENDADOS $SUGERIDOS htop
sudo apt-get install -y $RECOMENDADOS $SUGERIDOS gnupg
sudo apt-get install -y $RECOMENDADOS $SUGERIDOS debconf
sudo apt-get install -y $RECOMENDADOS $SUGERIDOS iftop

echo
echo "Configurar GIT"
echo
git config --global user.name $GIT_USER
git config --global user.email $GIT_EMAIL
git config --global core.editor vim
