# RPi_provision versión 0.1.3

Instalar cosillas en una Raspberry Pi. **Probado en placas 3B, 3B+ y 3A+ con Raspbian.**

Lo ideal es, partiendo de una [Raspbian Buster Lite](https://downloads.raspberrypi.org/raspbian_full_latest.torrent), tostarla  con [BalenaEtcher](https://www.balena.io/etcher/) o similar, clonar el repo, ejecutar el script `RPi_provision.sh` e ir seleccionando lo que se quiere instalar. Por el mismo precio, mejor guardar un log, por elemplo algo así:

`$ bash RPi_provision.sh | tee log_provision.txt` 

## Opciones disponibles

+ Crear un usuario (editar variables usuario/password antes de lanzar el script)
+ Safe shutdown para cajas Retroflag (NesPi+ y MegaPi)
+ Añadir aliases, modificar PS1 y otras cosillas al .profile del nuevo usuario y root
+ Actualizar paquetes del sistema
+ Actualizar el *firmware* de la RPi (bajo tu responsabilidad, si conviertes en un ladrillo tu RPi yo no quiero saber nada)
+ Instalar herramientas básicas (vim, htop, git, gnupg, debconf, et al.)
+ Apache y PHP
+ MariaDB
+ servidor SSH
+ servidor FTP
+ Golang
+ Geth
+ Node.js
+ MongoDB
+ Crear e instalar certificado Let’s Encrypt
+ Instalar Mate Desktop

+ Bonus: TextPattern CMS