#!/bin/bash

export GOACCESS_VERSION=1.3

sudo apt-get install -y libgeoip-dev libncursesw5-dev

cd
wget https://tar.goaccess.io/goaccess-$GOACCESS_VERSION.tar.gz
tar -xzvf goaccess-$GOACCESS_VERSION.tar.gz
rm goaccess-$GOACCESS_VERSION.tar.gz

cd goaccess-$GOACCESS_VERSION/
./configure --enable-utf8 --enable-geoip=legacy
make
sudo make install

