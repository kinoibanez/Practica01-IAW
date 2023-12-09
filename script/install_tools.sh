#!/bin/bash


#Esto muestra todos los comandos que se van ejecutando
set -x 

# Se importan las variables al nuevo archivo llamado .env 

source .env 
# Para comprobar que funciona podemos hacer lo siguiente:
#echo $PHPMYADMIN_APP_PASSWORD
#exit 
#Actualizamos los repositorios
apt update

#Actualizamos los paquetes de la máquina 

#apt upgrade -y

#Comandos para configurar las respuestas de la instalación de PhPMyAdmin

#Este echo muestra el servidor web, lo selecciona:
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
# Para configurar el parametro de la base de datos:

echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections

#Con este echo seleccionamos la contraseña:

echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections

echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections

#Instalamos phpmyadmin con todos los paquetes.

apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl 

#Creamos un usuario en PHPMYADMIN que tenga acceso a todas las bases de datos.
mysql -u root <<< "DROP USER IF EXISTS '$APP_USER'@'%'"

mysql -u root <<< "CREATE USER '$APP_USER'@'%' IDENTIFIED BY '$APP_PASSWORD';"

mysql -u root <<< "GRANT ALL PRIVILEGES ON *.* TO '$APP_USER'@'%';"

#Creamos el directorio para Adminer

mkdir -p /var/www/html/adminer

#Instalar Adminer atraves de una url de google.

wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php -P /var/www/html/adminer

#Renombramos el nombre del archuvo del adminer 

mv /var/www/html/adminer/adminer-4.8.1-mysql.php /var/www/html/adminer/index.php

#Modificamos el propietario y el grupo del directorio /var/Www/html

chown -R www-data:www-data /var/www/html

#Instalamos GoAccess

apt install goaccess -y


#Creamos un directorio para los informes html de GoAcces

mkdir -p /var/www/html/stats

#Ejecutamos GoAcces en segundo plano

#Aqui podemos observar una serie de parametros que nos sirven para volvar el archivo de html en tiempo real
# Daemonize ejecuta un proceso que se estará ejecutnado continuamente en segundo plano
#El long format nos permite poder elegir el formato que queremos utilizar, es un archivo de texto para lo servidores web
#Real - time nos permite indicar que programa queremos que se ejecute en tiempor reall.

goaccess /var/log/apache2/access.log -o /var/www/html/stats/index.html --log-format=COMBINED --real-time-html --daemonize

#El parametro -b nos permite que esta sentencia pueda ejecutarse en un script de bash.
# Protegemos el directorio, le ponemos control de acceso con autentificación básica.
#Creamos el archivo .htpasswd

htpasswd -bc /etc/apache2/sites-available/.htpasswd $STATS_USERNAME $STATS_PASSWORD
#Copiamos el archivo de configuración de Apache con la configuracino del acceso al directorio.

cp ../conf/000-default-stats.conf /etc/apache2/sites-available/000-default.conf

#Reiniciamos el servicio de apache

sudo systemctl restart apache2

