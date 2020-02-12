GETH_VERSION=1.9.6-bd059680

echo "+-------------------------+"
echo "|           GETH          |"
echo "+-------------------------+"
echo
echo -n "Instalar Geth? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
	cd 
	wget https://gethstore.blob.core.windows.net/builds/geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo tar -xvf geth-linux-arm7-$GETH_VERSION.tar.gz
	cd geth-linux-arm7-$GETH_VERSION
	sudo mv geth /usr/local/bin/
	cd
	rm geth-linux-arm7-$GETH_VERSION.tar.gz
	sudo rm -rf geth-linux-arm7-$GETH_VERSION
else
    echo Omitiendo la instalación de Geth
fi