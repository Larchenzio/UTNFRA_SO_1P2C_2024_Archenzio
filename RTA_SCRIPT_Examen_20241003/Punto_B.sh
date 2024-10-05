#!/bin/bash

# Encuentra el disco de 10 GiB y guarda su nombre en la variable DISCO
DISCO=$(sudo fdisk -l | grep Disk | grep "10 GiB" | awk -F ':' '{print $1}' | awk '{print $2}')

# Imprime el nombre del disco encontrado
echo "El disco encontrado es: $DISCO"
#Creamos la particion extendida de los 10GB, para luego crear las particiones logicas de 1GB, salvo la ultima que sera de menos de un 1GB.
sudo fdisk $DISCO << EOF
n
e



n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n


w
EOF

echo "Mostrar particiones"
sudo fdisk $DISCO -l

