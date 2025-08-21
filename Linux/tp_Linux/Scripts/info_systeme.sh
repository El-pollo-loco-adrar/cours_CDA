#!/bin/bash

#Affichage des infos

echo "L'utilisateur actuel est : $USER"
echo "L'espace disponible sur / : "
df -h / | awk 'NR==2 {print $4 " libres sur "$2}'
# df : disk free
# -h : human readable (lisible en k m g)
# / : à la racine
# awk : langage qui traite le texte par colonne
# NR==2 :le numéro de ligne
# print : la 4e ligne puis la 2e


echo "Les utilisateurs connectés sont : "
who
