#!/bin/bash
NAME='Sabiralishaik'

echo "Lenght of the array : ${#NAME}"

for (( i=0; i<${#NAME}; i++ )); do
    echo "${NAME:$i:1}"
done