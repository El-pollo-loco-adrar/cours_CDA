#!/bin/bash

# Suppression des fichiers Temp non modifié depuis 2 jours.

TARGET="/home/vboxuer/tp_Linux/Temp"

find "$TARGET" -type f -mtime +2 -exec rm {} \;

# commande find avec options :
#	-mtime +2 : fichiers dont la dernière modif date de plus de 2 jours
#	-type f : seulement les fichiers
#	-exec rm {} : execute la fonction rm(suppression) sur chaque fichier trouvé
