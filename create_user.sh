NEW_USER='woz'
NEW_USER_PWD='1234' # Ídem xD

echo "Creando usuario $NEW_USER"
echo
sudo useradd -m $NEW_USER
echo -e "$NEW_USER_PWD\n$NEW_USER_PWD" | sudo passwd -q 2>&1 $NEW_USER
sudo usermod -a -G sudo $NEW_USER