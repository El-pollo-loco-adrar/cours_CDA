//Créer un répertoire de travail
mkdir ~/tp_linux

//Créer un fichier vide 
touch ~/tp_linux/fichier1.txt

Supprimer le fichier 
rm ~/tp_linux/fichier1.txt

Créer un dossier et le supprimer 
mkdir ~/tp_linux/dossier_test
rm -r ~/tp_linux/dossier_test

Créer deux fichiers 
touch ~/tp_linux/fichier2.txt 
touch ~/tp_linux/fichier3.txt

Copier un fichier dans un sous-dossier 
mkdir ~/tp_linux/sauvegarde
cp ~/tp_linux/fichier2.txt ~/tp_linux/sauvegarde/

Déplacer et renommer un fichier 
mv ~/tp_linux/fichier3.txt ~/tp_linux/sauvegarde/fichier_renommé.txt

Créer un fichier avec du contenu 
echo -e "Ligne 1 \nLigne 2 \nLigne 3" > ~/tp_linux/test.txt

Afficher le contenu du fichier 
cat ~/tp_linux/test.txt

Afficher les 2 premières lignes 
head -n 2 ~/tp_linux/test.txt

Afficher les 2 dernières lignes
tail -n 2 ~/tp_linux/test.txt

Utiliser less pour consulter un fichier long 
less ~/tp_linux/test.txt  // :q pour sortir