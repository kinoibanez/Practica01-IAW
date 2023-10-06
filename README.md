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


## COMANDO TAIL -F
- Usando el comando tail -f acces.log nos sirve para poder registrar nos deja funcionando el comando que pongamos. Es decir, el log para que estemos pendientes del registro de lo que esta pasando. La *-f* nos sirve para dejar fijo la ultimas lineas, es decir, que se quede abierto.

- _tail -f_ nos servirá para utilizarlo dentro del apache, para poder comprobar las peticiones en error.log o por ejemplo en access.log.

- En la practica que hemos hecho de modificar un directorio /home/ubuntu/misitioweb tenemos que tener en cuenta que el puerto de conexión era el 80.


## Directorio y archivo sources.list
- Dentro del directorio /etc/apt/ y hacemos un sudo nano de source.list podemos ver el repositorio donde se almacenan los repositorios que actualizamos con el update y el upgrade.

- Update realmente te busca los nuevos archivos de texto que son diferentes a los que tenemos en la máquina. Y upgrade lo que hace es que busca las diferencias entre cada uno de ellos y lo mejora a la versión mas reciente.