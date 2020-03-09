#!/bin/bash

if [ $# -lt 2 ] ;then
	echo "Uso: create_user.sh <usuario> <password> [sudoer]"
	exit 1
fi

if id "$1" >/dev/null 2>&1; then
	echo "El usuario $1 ya existe."
	exit 2
else
	if [ -z $NEW_USER ] ;then
		source $(dirname $0)/settings.sh
	fi

	sudo useradd -m $1
	echo -e "$2\n$2" | sudo passwd -q 2>&1 $1 2>/dev/null

	if [ "$3" = "sudoer" ] ;then
		sudo usermod -a -G sudo $1
	elif [ -n "$3" ]; then
		echo "El tercer parámetro no es válido, sólo se admite la cadena 'sudoer'."
		echo "El usuario $1 no se añadirá a los sudoers"
	else
		echo "Creado usuario $1."
	fi
fi