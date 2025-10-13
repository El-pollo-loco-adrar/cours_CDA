<?php

//Création d'un tableau vide
$tab = [];
//ajout de colonnes (tableau associatif)
$tab["prenom"] = "Mathieu";
$tab["nom"] = "Adrar";
$tab["email"] = "mathieu@test.com";

//Tableau indexé (avec des valeurs)
$tab_indexe = [0,15,22,33,47];
//Ajout d'une colonne tableau indexé
$tab_indexe[] = 20;

//Itération tableau associatif
foreach ($tab as $key => $value) {
    echo $key . " : " . $value . "<br>";
}

//Itération tableau indexe
foreach ($tab_indexe as $key => $value) {
    echo $key . " : " . $value . "<br>";
}

//Iteration tableau indexé avec la boucle for
for ($i=0; $i < count($tab_indexe); $i++) { 
    echo $tab_indexe[$i] . "<br>";
}

//compteur (index)
$cpt = 0;
//Itération tableau indexé avec la boucle while
while($cpt <count($tab_indexe)) {
    echo $tab_indexe[$i] . "<br>";
    $cpt++;
}