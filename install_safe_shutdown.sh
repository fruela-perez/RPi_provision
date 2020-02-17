echo "+-------------------------+"
echo "| Retroflag Safe shutdown |"
echo "+-------------------------+"
echo
echo -n "¿Instalar script? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando...
    echo
	wget -O - "https://raw.githubusercontent.com/RetroFlag/retroflag-picase/master/install.sh" | sudo bash
else
    echo Omitiendo la instalación
fi