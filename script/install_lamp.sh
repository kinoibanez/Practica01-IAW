#!/bin/bash

#Esto muestra todos los comandos que se van ejecutando
set -x 
#Actualizamos los repositorios
apt update

#Actualizamos los paquetes de la máquina 

apt upgrade -y

# Instalamos el servidor web apache

apt install apache2 -y

