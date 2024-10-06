#!/bin/bash

echo "Creo estructura de directorio"

sudo mkdir -p /Examenes_UTN/{alumno_{1..3}/parcial_{1..3},profesores}

echo "Mostramos estrcutura"
tree /Examenes_UTN
