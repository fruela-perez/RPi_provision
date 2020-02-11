#!/bin/bash

SHELL=/bin/bash

# Instalar Mate Desktop

echo "+-------------------------+"
echo "|       Mate Desktop      |"
echo "+-------------------------+"
echo
echo -n "¿Instalar Mate Desktop? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando...
    echo
	bash ./install_mate_1.sh
else
    echo Omitiendo la instalación
fi
