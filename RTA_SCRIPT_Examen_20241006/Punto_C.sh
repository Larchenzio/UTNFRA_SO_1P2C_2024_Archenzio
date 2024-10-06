#!/bin/bash

echo "creamos los grupos"

sudo groupadd p1c2_2024_gAlumno
sudo groupadd p1c2_2024_gProfesores

echo "Grupos creados:"
grep -i p1c2_2024_g /etc/group


echo "Creamos los usuarios y los agregamos al grupo"
CLAVE=$(sudo grep "$(whoami)" /etc/shadow | awk -F ':' '{print $2}')
USUARIO=$(whoami)

sudo useradd -m -s /bin/bash -G p1c2_2024_gAlumno -p "$CLAVE" p1c2_2024_A1
sudo useradd -m -s /bin/bash -G p1c2_2024_gAlumno -p "$CLAVE" p1c2_2024_A2
sudo useradd -m -s /bin/bash -G p1c2_2024_gAlumno -p "$CLAVE" p1c2_2024_A3
sudo useradd -m -s /bin/bash -G p1c2_2024_gProfesores -p "$CLAVE" p1c2_2024_P1

echo "Usuarios creados y asignados a los grupos correspondientes."

echo "Valido que tengan la misma clave"
# Valido que tengan la misma clave
sudo grep -E 'p1c2_2024_A1|p1c2_2024_A2|p1c2_2024_A3|p1c2_2024_P1' /etc/shadow | awk -F ':' '{print $2}'

echo "Revisamos si hay diferencias"
# Si quisiera ver si hay diferencias con un diff...
diff <(sudo grep 'p1c2_2024_A1' /etc/shadow | awk -F ':' '{print $2}') <(sudo grep 'p1c2_2024_A2' /etc/shadow | awk -F ':' '{print $2}')

# useradd: Crea nuevos usuarios.
# -m: Crea un directorio home para el usuario.
# -G: Agrega el usuario a grupos secundarios.
# -p: Establece la contraseña del usuario whoami = vagrant


echo "Ajustamos permisos"
sudo chown -R p1c2_2024_A1:p1c2_2024_gAlumno /Examenes_UTN/alumno_1
sudo chmod -R 750 /Examenes_UTN/alumno_1 #drwxr-x---

sudo chown -R p1c2_2024_A2:p1c2_2024_gAlumno /Examenes_UTN/alumno_2
sudo chmod -R 760 /Examenes_UTN/alumno_2 #drwxrw----

sudo chown -R p1c2_2024_A3:p1c2_2024_gAlumno /Examenes_UTN/alumno_3
sudo chmod -R 700 /Examenes_UTN/alumno_3 #drwx------

sudo chown -R p1c2_2024_P1:p1c2_2024_gProfesores /Examenes_UTN/profesores
sudo chmod -R 775 /Examenes_UTN/profesores #drwxrwxr-x


 sudo ls -l /Examenes_UTN/



echo "Creamos archivo validar.tx"
# Crear archivos validar.txt con el comando whoami
sudo su p1c2_2024_A1 bash -c "whoami > /Examenes_UTN/alumno_1/validar.txt"
sudo su p1c2_2024_A2 bash -c "whoami > /Examenes_UTN/alumno_2/validar.txt"
sudo su p1c2_2024_A3 bash -c "whoami > /Examenes_UTN/alumno_3/validar.txt"
sudo su p1c2_2024_P1 bash -c "whoami > /Examenes_UTN/profesores/validar.txt"

echo "Permisos ajustados y archivos validar.txt creados."
sudo cat /Examenes_UTN/alumno_1/validar.txt
sudo cat /Examenes_UTN/alumno_2/validar.txt
sudo cat /Examenes_UTN/alumno_3/validar.txt
sudo cat /Examenes_UTN/profesores/validar.txt
