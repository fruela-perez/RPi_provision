if [ $# -lt 2 ] ;then
	echo
	echo "Uso: create_user.sh <usuario> <password> [sudoer]"
	echo
	exit 1
fi

if id "$1" >/dev/null 2>&1; then
	echo "El usuario $1 ya existe."
	echo
	exit 2
else

	echo
	echo "+---------------------------+"
	echo "| Crear usuario $1"
	echo "+---------------------------+"
	echo
	sudo useradd -m $1
	echo -e "$2\n$2" | sudo passwd -q 2>&1 $NEW_USER 2>/dev/null

	if [ "$3" = "sudoer" ] ;then
		sudo usermod -a -G sudo $1
	elif [ -n "$3" ]; then
		echo "El tercer parámetro no es válido, sólo se admite la cadena 'sudoer'."
		echo "El usuario $1 no se añadirá a los sudoers"
		echo
	else
		echo
	fi
fi

echo

