# RPi Provision - versión 0.2

Instalar *cosas* en una Raspberry Pi. 

**Probado en placas 3B, 3B+ y 3A+ con [Raspbian *Buster* Lite](http://downloads.raspberrypi.org/raspbian/release_notes.txt).**

## Uso

1. Tostar una [Raspbian Buster Lite](https://downloads.raspberrypi.org/raspbian_full_latest.torrent) con [BalenaEtcher](https://www.balena.io/etcher/) o similar. 
2. Insertar la tarjeta en la Raspberry, arranca el sistema y ejecuta `sudo raspi-config`.
   1. Cambia la contraseña del usuario pi.
   2. Establece el nombre de la máquina.
   3. Configura la red.
   4. Selecciona las locales.
   5. Establece la zona horaria.
3. Instalar git (no está incluido en la versión Lite): `sudo apt-get install -y git`.
4. Clonar el repositorio: `git clone https://github.com/fruela-perez/RPi_provision.git`.
5. Editar el archivo `settings.sh`, modificar usuarios, passwords y números de versión según proceda.
6. Ejecutar el script `setup.sh` e ir seleccionando lo que se quiere instalar (**N.B.:** Si seleccionas los paquetes recomendados y sugeridos, te puede llevar media vida terminar la instalación). 

## Opciones disponibles

+ Añadir aliases, modificar PS1 y otras cosillas al .profile del usuario `pi`, `root` y en `/etc/skel`
+ Actualizar paquetes del sistema
+ Actualizar el *firmware* de la RPi (bajo tu responsabilidad, si se convierte en un ladrillo yo no quiero saber nada)
+ *basic stuff* (vim, htop, git, gnupg, debconf, et al.)
+ Apache y PHP
+ MariaDB
+ servidor SSH
+ servidor FTP
+ [Golang](https://golang.org/)
+ [Go Ethereum](https://geth.ethereum.org/), a.k.a.  Geth
+ Node.js y MongoDB
+ [WiringPi](http://wiringpi.com/) y [Pi4J](https://pi4j.com/1.2/index.html)
+ NetBeans
+ Crear e instalar certificado de [Let’s Encrypt](https://letsencrypt.org/)
+ Mate Desktop
+ [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki)
+ [TextPattern CMS](https://textpattern.com/)
+ Crear un nuevo usuario.
+ Eliminar el usuario `pi`.
+ Instalar *safe shutdown* para cajas [Retroflag](http://retroflag.com/) (NesPi+ y MegaPi).
