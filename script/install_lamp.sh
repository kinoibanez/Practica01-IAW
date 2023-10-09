#!/bin/bash

#Esto muestra todos los comandos que se van ejecutando
set -x 
#Actualizamos los repositorios
apt update

#Actualizamos los paquetes de la máquina 

#apt upgrade -y

# Instalamos el servidor web apache A.

apt install apache2 -y

# Instalamos Mysql L.

sudo apt install mysql-server -y

# Instalamos PHP.

sudo apt install php libapache2-mod-php php-mysql -y

# Copiar archivo de configuración de apache

cp ../conf/000-default.conf /etc/apache2/sites-available

# Reiniciamos el servicio (apache)

systemctl restart  apache2

#Copiamos el archivo de prueba de php 

cp ../php/index.php /var/www/html 

# Modificamos el propietario y el grupo del directorio /var/www/htlm

chown -R www-data:www-data /var/www/html




