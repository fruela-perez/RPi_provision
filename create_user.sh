if [ $# -lt 2 ] ;then
	echo
	echo "Uso: create_user.sh <usuario> <password> [sudoer]"
	echo
	exit 1
fi

sudo useradd -m $1
echo -e "$2\n$2" | sudo passwd -q 2>&1 $NEW_USER

if [ "$3" = "sudoer" ] ;then
	sudo usermod -a -G sudo $1
fi

echo

