#!/bin/bash

echo "+-------------------------+"
echo "|    Actualizar sistema   |"
echo "+-------------------------+"

sudo apt update
sudo apt upgrade

echo "+-------------------------+"
echo "|   Actualizar firmware   |"
echo "+-------------------------+"

sudo rpi-update

echo "+-------------------------+"
echo "|      Basic cosillas     |"
echo "+-------------------------+"

sudo apt-get install -y vim ctags vim-doc vim-scripts
sudo apt-get install -y git
sudo apt-get install -y htop

echo "+-------------------------+"
echo "|           SSH           |"
echo "+-------------------------+"

sudo systemctl enable ssh
sudo systemctl start ssh

echo "+-------------------------+"
echo "|           FTP           |"
echo "+-------------------------+"

sudo apt-get install -y vsftpd
sudo cp vsftpd.conf /etc/vsftpd.conf
sudo service vsftpd restart

echo "+-------------------------+"
echo "|      Let’s Encrypt      |"
echo "+-------------------------+"

sudo apt-get install -y python-certbot-apache
sudo apt-get install certbot
sudo certbot --apache

echo "+-------------------------+"
echo "|         .profile        |"
echo "+-------------------------+"

cp profile ~/.profile

echo "+-------------------------+"
echo "|         GOLANG          |"
echo "+-------------------------+"

cd 
wget https://dl.google.com/go/go1.13.7.linux-armv6l.tar.gz
sudo tar -C /usr/local -xzf go1.13.7.linux-armv6l.tar.gz
rm go1.13.7.linux-armv6l.tar.gz

echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
echo "GOPATH=$HOME/golang" >> ~/.profile

source ~/.profile

which go
go version

echo "+-------------------------+"
echo "|           GETH          |"
echo "+-------------------------+"

# sudo apt-get -y install dphys-swapfile build-essential libgmp3-dev curl
# cd 
# git clone https://github.com/ethereum/go-ethereum
# cd go-ethereum
# sudo make geth

GETH_VERSION=1.9.6-bd059680

cd 
wget https://gethstore.blob.core.windows.net/builds/geth-linux-arm7-$GETH_VERSION.tar.gz
sudo tar -xvf geth-linux-arm7-$GETH_VERSION.tar.gz
cd geth-linux-arm7-$GETH_VERSION
sudo mv geth /usr/local/bin/
cd
rm geth-linux-arm7-$GETH_VERSION.tar.gz


