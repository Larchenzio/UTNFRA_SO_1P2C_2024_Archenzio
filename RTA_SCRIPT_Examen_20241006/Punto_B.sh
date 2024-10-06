#!/bin/bash

echo "Buscando disco..."
echo
# Encuentra el disco de 10 GiB y guarda su nombre en la variable DISCO
DISCO=$(sudo fdisk -l | grep Disk | grep "10 GiB" | awk -F ':' '{print $1}' | awk '{print $2}')

# Imprime el nombre del disco encontrado
echo "El disco encontrado es: $DISCO"

echo "Creamos las particiones"
echo
# Crea 10 particiones iguales, lo genero asi ya que probe ocn un for y al correrlo me arroja un error
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

echo "Mostramos las particiones"

sudo fdisk -l |grep "$DISCO"

echo "Actualizando el sistema"
#Actualiza el sistema para reconocer las nuevas particiones
sudo partprobe $DISCO

echo "Formateo de las particiones"
# Formatea cada partición con ext4
for i in {5..14}; do
    sudo mkfs.ext4 ${DISCO}${i}
done

echo "Añadiendo las particiones de forma persistente"
particion=5
for alumno in {1..3}; do
    for parcial in {1..3}; do
        echo "/dev/sdc${particion} /Examenes_UTN/alumno_${alumno}/parcial_${parcial} ext4 defaults 0 0" | sudo tee -a /etc/fstab
        particion=$((particion + 1))
    done
done
echo "/dev/sdc14 /Examenes_UTN/profesores ext4 defaults 0 0" | sudo tee -a /etc/fstab

echo "Montamos las particiones"
sudo mount -a

echo "Mostramos el uso del espacio"
df -h
