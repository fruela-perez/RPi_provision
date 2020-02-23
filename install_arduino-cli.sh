#!/bin/bash

echo "+-------------------------+"
echo "|          Arduino        |"
echo "+-------------------------+"
echo
echo -n "Instalar arduino-cli? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

    #go get -u github.com/arduino/arduino-cli
    sudo mv ~/go/bin/arduino-cli /bin
else
    echo Omitiendo la instalación de arduino-cli
fi
