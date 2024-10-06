#!/bin/bash

# Obtener la IP pública
ip_publica=$(curl -s ifconfig.me)

# Obtener la URL del repositorio remoto
url_repo=$(git -C $HOME/repogit/UTNFRA_SO_1P2C_2024_Archenzio remote get-url origin)

# Crear el archivo Filtro_Avanzado.txt y escribir la información
cat > $HOME/repogit/UTNFRA_SO_1P2C_2024_Archenzio/RTA_ARCHIVOS_Examen_20241006/Filtro_Avanzado.txt <<EOF
Mi IP Pública es: $ip_publica
Mi usuario es: $(whoami)
El Hash de mi usuario es: $(sha256sum /etc/passwd | cut -d' ' -f1)
La URL de mi repositorio es: $url_repo
EOF
echo "Mostramos la informacion del archivo"
cat $HOME/repogit/UTNFRA_SO_1P2C_2024_Archenzio/RTA_ARCHIVOS_Examen_20241006/Filtro_Avanzado.txt
