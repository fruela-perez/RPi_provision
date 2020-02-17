echo "+-------------------------+"
echo "|           SSH           |"
echo "+-------------------------+"
echo
echo -n "¿Instalar servidor SSH? [s/N] "
read respuesta

if [ "$respuesta" != "${respuesta#[Ss]}" ] ;then
    echo Instalando servidor SSH...
    echo
	sudo systemctl enable ssh
	sudo systemctl start ssh
	# Remove GNU licence and 'no warranty' when logging into ssh
	touch ~/.hushlogin
	touch /etc/skel/.hushlogin
else
    echo Omitiendo la instalación del servidor SSH
fi
