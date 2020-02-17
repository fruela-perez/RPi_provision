#!/bin/bash

# Instalar WiringPi

echo "+-------------------------+"
echo "|     WiringPi y Pi4J     |"
echo "+-------------------------+"
echo
echo -n "¿Instalar WiringPi y Pi4J? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando WiringPi...
    echo
    sudo apt-get install -y wiringpi

    # Test instalación

    gpio -v
    gpio readall

    # Instalar Pi4J

    echo Instalando Pi4J...
    echo
    curl -sSL https://pi4j.com/install | sudo bash
else
    echo Omitiendo la instalación.
fi

# Installed Location / Example Files
# 
# This will install the Pi4J libraries and example source files to:
# /opt/pi4j/lib
# /opt/pi4j/examples
# 
# When attempting to compile a Java program using the Pi4J libraries, make sure to include the Pi4J lib folder in the classpath:
# javac -classpath .:classes:/opt/pi4j/lib/'*' ...
# 
# When attempting to start a Java program using the Pi4J libraries, make sure to include the Pi4J lib folder in the classpath:
# sudo java -classpath .:classes:/opt/pi4j/lib/'*' ...
# 
# If you would like to explore the examples, you can compile all the examples with the following commands:
# /opt/pi4j/examples/build