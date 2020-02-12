echo "+--------------------------+"
echo "|     nodejs & mongodb     |"
echo "+--------------------------+"
echo
echo -n "Instalar nodejs? [s/N] "
read respuesta
echo
if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

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

	sudo apt-get install -y $RECOMENDADOS $SUGERIDOS npm nodejs
else
    echo Omitiendo la instalación de nodejs
fi

echo
echo -n "Instalar mongodb? [s/N] "
read respuesta  

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then

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

	sudo apt-get install -y $RECOMENDADOS $SUGERIDOS mongodb-server
else
    echo Omitiendo la instalación de nodejs
fi
