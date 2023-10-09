#!/bin/bash

#Declaramos la variables 
#-----------------------------------------------------------
PHPMYADMIN_APP_PASSWORD=123456
APP_USER=Joaquin
APP_PASSWORD=12345
#-----------------------------------------------------------
#Esto muestra todos los comandos que se van ejecutando
set -x 
#Actualizamos los repositorios
apt update

#Actualizamos los paquetes de la máquina 

#apt upgrade -y

#Comandos para configurar las respuestas de la instalación de PhPMyAdmin

echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections

echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections

echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections

#Instalamos phpmyadmin con todos los paquetes.

sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y

#Creamos un usuario en PHPMYADMIN que tenga acceso a todas las bases de datos.
mysql -u root <<< "DROP USER IF EXISTS '$APP_USER'@'%'"

mysql -u root <<< "CREATE USER '$APP_USER'@'%' IDENTIFIED BY '$APP_PASSWORD';"

mysql -u root <<< "GRANT ALL PRIVILEGES ON *.* TO '$APP_USER'@'%';"


