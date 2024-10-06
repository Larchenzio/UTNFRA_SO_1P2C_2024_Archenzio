#!/bin/bash

echo "creamos los grupos"

sudo groupadd p1c2_2024_gAlumno
sudo groupadd p1c2_2024_gProfesores

echo "Creamos los usuarios y los agregamos al grupo"

sudo useradd -m -G p1c2_2024_gAlumno -p $(openssl passwd -crypt 'tu_clave') p1c2_2024_A1
sudo useradd -m -G p1c2_2024_gAlumno -p $(openssl passwd -crypt 'tu_clave') p1c2_2024_A2
sudo useradd -m -G p1c2_2024_gAlumno -p $(openssl passwd -crypt 'tu_clave') p1c2_2024_A3
sudo useradd -m -G p1c2_2024_gProfesores -p $(openssl passwd -crypt 'tu_clave') p1c2_2024_P1

# useradd: Crea nuevos usuarios.
# -m: Crea un directorio home para el usuario.
# -G: Agrega el usuario a grupos secundarios.
# -p: Establece la contraseña encriptada del usuario.


echo "Ajustamos permisos"
sudo chown -R p1c2_2024_A1:p1c2_2024_A1 /Examenes_UTN/alumno_1
sudo chmod -R 750 /Examenes_UTN/alumno_1 #drwxr-x---

sudo chown -R p1c2_2024_A2:p1c2_2024_A2 /Examenes_UTN/alumno_2
sudo chmod -R 760 /Examenes_UTN/alumno_2 #drwxrw----

sudo chown -R p1c2_2024_A3:p1c2_2024_A3 /Examenes_UTN/alumno_3
sudo chmod -R 700 /Examenes_UTN/alumno_3 #drwx------

sudo chown -R p1c2_2024_P1:p1c2_2024_gProfesores /Examenes_UTN/profesores
sudo chmod -R 775 /Examenes_UTN/profesores #drwxrwxr-x

# Crear archivos validar.txt con el comando whoami
sudo -u p1c2_2024_A1 bash -c "whoami > /Examenes_UTN/alumno_1/validar.txt"
sudo -u p1c2_2024_A2 bash -c "whoami > /Examenes_UTN/alumno_2/validar.txt"
sudo -u p1c2_2024_A3 bash -c "whoami > /Examenes_UTN/alumno_3/validar.txt"
sudo -u p1c2_2024_P1 bash -c "whoami > /Examenes_UTN/profesores/validar.txt"
