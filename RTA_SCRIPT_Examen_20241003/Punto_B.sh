#!/bin/bash

# Encuentra el disco de 10 GiB y guarda su nombre en la variable DISCO
DISCO=$(sudo fdisk -l | grep Disk | grep "10 GiB" | awk -F ':' '{print $1}' | awk '{print $2}')

# Imprime el nombre del disco encontrado
echo "El disco encontrado es: $DISCO"

# Crea 10 particiones iguales
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

# Actualiza el sistema para reconocer las nuevas particiones
sudo partprobe $DISCO

# Formatea cada partición con ext4
for i in {5..14}; do
    sudo mkfs.ext4 ${DISCO}${i}
done

# Crea los puntos de montaje personalizados si no existen
for alumno in {1..3}; do
    for parcial in {1..3}; do
        sudo mkdir -p /mnt/Examenes_UTN/alumno_$alumno/parcial_$parcial
    done
done
sudo mkdir -p /mnt/Examenes_UTN/profesores

# Monta las particiones de forma persistente y de inmediato
particion=5
for alumno in {1..3}; do
    for parcial in {1..3}; do
        echo "${DISCO}${particion} /mnt/Examenes_UTN/alumno_${alumno}/parcial_${parcial} ext4 defaults 0 2" | sudo tee -a /etc/fstab
        sudo mount ${DISCO}${particion} /mnt/Examenes_UTN/alumno_${alumno}/parcial_${parcial}
        particion=$((particion + 1))
    done
done
echo "${DISCO}14 /mnt/Examenes_UTN/profesores ext4 defaults 0 2" | sudo tee -a /etc/fstab
sudo mount ${DISCO}14 /mnt/Examenes_UTN/profesores

# Mostrar el uso del espacio en disco
df -h
for i in {5..14}; do
    lsblk -f ${DISCO}${i}
done
