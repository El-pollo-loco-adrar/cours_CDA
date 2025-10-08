<?php
/*
Ecrivez une fonction permettant à l’utilisateur de saisir un nombre quelconque de valeurs, qui devront être stockées dans un tableau. 
L’utilisateur doit donc commencer par entrer le nombre de valeurs qu’il compte saisir.
Il effectuera ensuite cette saisie. 
Enfin, une fois la saisie terminée, la fonction affichera le nombre de valeurs négatives et le nombre de valeurs positives. (Fonction retourne void, on affiche le résultat dans le termina
Ecrivez une fonction permettant à l’utilisateur de saisir un nombre quelconque de valeurs, qui devront être stockées dans un tableau. 
L’utilisateur doit donc commencer par entrer le nombre de valeurs qu’il compte saisir.
Il effectuera ensuite cette saisie. 
Enfin, une fois la saisie terminée, la fonction affichera le nombre de valeurs négatives et le nombre de valeurs positives.
on affiche le résultat dans le terminal
*/
function saisieNombre() : array {
    $nbValeur = (int)readline("Combien de valeurs voulez vous entrer ? ");
    return [$nbValeur];
}
$nbValeur = saisieNombre()[0];
$nbNeg = 0;
$nbPos = 0;
for($i = 0; $i<$nbValeur; $i++) {
    $nbs = (int)readline("Entrez un nombre : ");
    if($nbs >= 0) {
        $nbPos++;
    } else {
        $nbNeg++;
    }
}
echo "Vous avez entré $nbPos valeurs positives et $nbNeg valeurs négatives.";

/*
Pour son nouveau spectacle, un mentaliste a besoin d'un programme pour s'exercer à deviner un nombre entre 1 et 100.
Pour réussir son tour il doit deviner le nombre en moins de 10 tentatives.
A chaque tour il va demander si le nombre qu’il énonce est plus petit ou plus grand.
S’il réussit à découvrir le nombre en moins de 10 essais, son entrainement acharné a payé, 
sinon il est un mauvais mentaliste et il va devoir changer de métier.
Il souhaite savoir en cas de réussite le nombre d'essai qu'il a effectué pour trouver le nombre.
Ecrire un programme qui va l'aider à s'entrainer dans le langage de votre choix.
NB : Le programme va s'éxécuter dans le terminal.*/