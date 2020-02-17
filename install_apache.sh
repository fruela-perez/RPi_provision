echo "+-------------------------+"
echo "|          APACHE         |"
echo "+-------------------------+"
echo
echo -n "¿Instalar Apache? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando Apache...
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

	sudo apt-get install -y $RECOMENDADOS $SUGERIDOS dirmngr apache2
	sudo apt-get -y autoremove

	sudo cp files/000-default.conf /etc/apache2/sites-available/
	sudo cp files/default-ssl.conf /etc/apache2/sites-available/
else
    echo Omitiendo la instalación de Apache
fi