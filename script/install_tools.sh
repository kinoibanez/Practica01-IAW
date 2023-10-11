#!/bin/bash

# Se importan las variables al nuevo archivo llamado variables.sh

source variable.env 
# Para comprobar que funciona podemos hacer lo siguiente:
#echo $PHPMYADMIN_APP_PASSWORD
#exit 
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

#Creamos el directorio para Adminer

sudo mkdir -p /var/www/html/adminer

#Instalar Adminer atraves de una url de google.

sudo wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php -P /var/www/html/adminer

#Renombramos el nombre del archuvo del adminer 

mv /var/www/html/adminer/adminer-4.8.1-mysql.php /var/www/html/adminer/index.php

#Modificamos el propietario y el grupo del directorio /var/Www/html

chown -R www-data:www-data /var/www/html

#Instalamos GoAccess

sudo apt-get install goaccess -y

#Creamos un directorio para los informes htlm de GoAcces

mkdir -p /var/www/html/stats

#Ejecutamos GoAcces en segundo plano

sudo goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html --daemonize

# Protegemos el directorio, le ponemos control de acceso con autentificación básica.
#Creamoe el archivo .htpasswd

sudo htpasswd -bc /etc/apache2/.htpasswd $STATS_USERNAME $STATS_PASSWORD

#Copiamos el archivo de configuración de Apache con la configuracino del acceso al directorio.

cp ../conf/000-default-stats.conf /etc/apache2/sites-available/000-default.conf

#Reiniciamos el servicio de apache

sudo systemctl restart apache2
