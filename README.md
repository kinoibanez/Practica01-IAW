# Practica01-IAW

## Aqui vamos a empezar con la primera práctica.

- Tenemos que crear como primer paso 2 carpetas. Images y Scripts.

- Dentro de script creamos el primero llamado install_lamp.sh

- Muy importante que todos las acciones estilo **echo**, **read**, etc... hay que ponerlo en miniscula.



## COMPROBAR FUNCIONAMIENTO DE APACHE

- Accedemos al directorio /etc/apache2 y para comprobar el estado de apache haremos un **_sudo systemctl status apache2_** 

1. Tendremos que comprobar que esta funcinando.

- Para apagarlo haremos un **_sudo systemctl stop apache2_** , muy importante comprobar con el status que esta apagado.

2. Para iniciarlo tendremos que hacer lo contrario. **_sudo systemctl start apache2_**


## Para abrir puertos en nuestra máquina de amazon.
- Para abrir puertos lo que tenemos que hacer es pulsar en nuestra instancia, en grupos de seguridad ,y en el numero de la ip. Desde ahi podemos configurar los puertos que queremos abrir o cerrar.

- Después de hacer eso tendremos que hacer un **_RESTART_** para que funcione. En este caso un systemctl restar apache2.
## Apuntes importantes de apache
- Archivo:  cat ports.conf: nos sale los puertos que tenemos a la escucha.

- En el directorio _sites-available_ encontraremos un archivo llamado **_000-default.conf_** el virtualhost explica todas las reglas de configuración que haya dentro de un servidor / dominio. Para acceder a el hacemos un cd a _sites-available_ y entramos en el archivo con un sudo nano.

- El apartado **Document Root** apunta a directorios diferentes, te lo redirige, lo que hace es que cuando alguien haga una peticion al puerto, el buscara el html por ejemplo.

- **Log_Level** siempre suele ponerse en modo estricto para que no influya todo el rato en la máquina con las peticiones.

- **Acess.log** registra el acceso de la gente a la máquina.

- Desde el directorio **/var/www/html$  sudo nano index.html** podemos modificar el archivo HTML de nuestro página y guardarlo. Encontraremos dentro de ese archivo todo el codigo de la página.

- **cd /etc/apache2/mods-enabled/** Sirve para ver los modulos.


- WWW.DATA es un usuario y con chown cambiados propietario y grupo. WWW es un usuario del sistema operativo. Con -R le damos permisos.

- El comando **Tee** recoge la entrada entrada estandar y la redirecciona a la salida de un fichero.


## COMANDO TAIL -F
- Usando el comando tail -f acces.log nos sirve para poder registrar nos deja funcionando el comando que pongamos. Es decir, el log para que estemos pendientes del registro de lo que esta pasando. La *-f* nos sirve para dejar fijo la ultimas lineas, es decir, que se quede abierto.

- _tail -f_ nos servirá para utilizarlo dentro del apache, para poder comprobar las peticiones en error.log o por ejemplo en access.log.

- En la practica que hemos hecho de modificar un directorio /home/ubuntu/misitioweb tenemos que tener en cuenta que el puerto de conexión era el 80.


## Directorio y archivo sources.list
- Dentro del directorio /etc/apt/ y hacemos un sudo nano de source.list podemos ver el repositorio donde se almacenan los repositorios que actualizamos con el update y el upgrade.

- Update realmente te busca los nuevos archivos de texto que son diferentes a los que tenemos en la máquina. Y upgrade lo que hace es que busca las diferencias entre cada uno de ellos y lo mejora a la versión mas reciente.

## BORRAR PAQUETES

**Remove** te sirve para borrar los paquetes pero no borra los archivos de configuración.

**Purge** borra todo, incluidos los archivos de configuración.


## Buscar información de un paquete

- Hacemos uso del comando *_sudo show nombredelpaquete_* y podemos verlo.

## Habilitar modulo.
- Para habilitar el modulo tenemos que hacer uso del comando  **sudo a2enmod rewrite** y después tendremos que hacer un restart del apache para que funcione correctamente. 

- En este caso *rewrite* sería el nombre del modulo.

## CAMBIAR ORDEN
La directiva DirectoryIndex se utiliza para configurar el orden prioridad de los archivos que se van a mostrar cuando se accede a un directorio. Por ejemplo, si un directorio tiene los archivos index.html y index.php, el servidor enviará al usuario el archivo que aparezca antes en la lista de prioridad de la directiva DirectoryIndex.

Si la configuración fuese esta:

DirectoryIndex index.php index.html
El servidor enviaría al usuario el archivo index.php.

Esta directiva se puede configurar a nivel global en el archivo de configuración:

/etc/apache2/mods-available/dir.conf
O también se puede configurar dentro de cada uno de los sitios virtuales en:

/etc/apache2/sites-available/
Ejemplo en el archivo /etc/apache2/mods-available/dir.conf:

DirectoryIndex index.php index.html index.cgi index.pl index.php index.xhtml index.htm
Ejemplo en un host virtual:
``
<VirtualHost *:80>
    #ServerName www.example.com
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/

    DirectoryIndex index.php index.html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
`

## CURL

- Te proporciona una pagina web a comandos. Es decir tienes que poner curl y la pagina http con su ruta para hacer uso y te saldrá el contenido de la página

## curl -Iv

- I con curl sirve para que me muestre las cabeceras
- V verbose sirve para mostrar paso por paso que ha ido haciendo.

# INSTALACIÓN DE MYSQL.

- Empezamos con la configuracion

## Metodos para comprobar el estado
- sudo systemctl start mysql
- sudo systemctl stop mysql
- sudo systemctl restart mysql
- sudo systemctl status mysql

## Como acceder a mysql.

- Hacemos uso del comando `*_mysql -u root_*`

# INSTALAR PHP.

- Comando de instalación: sudo apt install php libapache2-mod-php php-mysql

- Todos los archivos de php empiezan por `<?php`

- Ponemos esto phpinfo(): siempre.

- Podemos exportar la siguiente sintaxis: 
 ´
`ServerSignature Off     
ServerTokens Prod`

 `
 <VirtualHost *:80>
    #Servername www.example.com
    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost> 
`



