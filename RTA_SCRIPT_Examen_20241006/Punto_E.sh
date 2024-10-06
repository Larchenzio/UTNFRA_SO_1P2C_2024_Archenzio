#!/bin/bash


grep MemTotal /proc/meminfo > $HOME/repogit/UTNFRA_SO_1P2C_2024_Archenzio/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt

sudo dmidecode -t chassis | grep Manufacturer >> $HOME/repogit/UTNFRA_SO_1P2C_2024_Archenzio/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt
echo" Mostramos memoria total y fabricante de chasis"
echo
cat $HOME/repogit/UTNFRA_SO_1P2C_2024_Archenzio/RTA_ARCHIVOS_Examen_20241006/Filtro_Basico.txt
