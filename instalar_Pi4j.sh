#!/bin/bash


# Instalar WiringPi

sudo apt-get install -y wiringpi

# Test instalación

gpio -v
gpio readall

# Instalar Pi4J

curl -sSL https://pi4j.com/install | sudo bash