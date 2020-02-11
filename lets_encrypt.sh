echo
echo "+-------------------------+"
echo "|      Let’s Encrypt      |"
echo "+-------------------------+"
echo
echo -n "Crear e instalar certificado https? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Creando e instalando certificado...
    echo
	sudo apt-get install -y --install-suggests python-certbot-apache
	sudo apt-get install certbot
	sudo certbot --apache
else
    echo Omitiendo la instalación del certificado
fi

