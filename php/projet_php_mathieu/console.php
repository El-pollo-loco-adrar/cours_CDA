<?php
/*
Créer un programme qui va ajouter les notes des élèves avec leur prénom et la note.
1 créer un tableau $notes vide.
Le tableau sera un tableau indexé.
2 écrire une fonction qui va 
demander de saisir le nombre de notes, cette valeur sera stockée dans un variable $nbrNotes,
faire une boucle et répéter ( autant que la valeur de $nbrNotes)
à chaque tour vous allez demander les informations suivantes :
avec la méthode readline() (lire dans la console : terminal)
le prénom , la note,
ces valeurs seront stockées dans un tableau,
le tableau sera ajouté dans le tableau notes (tableau indexé avec à chaque colonne un tableau associatif composé du prénom et de la note)
à la fin de la boucle vous allez afficher (avec echo)  :
1 l'élève avec la meilleure note (prénom et la note),
2 l'élève avec la note la plus base (prénom et la note).

NB : le script sera lancé comme ci-dessous :
dans le terminal saisir :
*/


$notes = [];
function askNotes() : int{
    $nbrNotes = (int)readline("Combien de notes voulez-vous entrer ? ");
    return $nbrNotes; 
    }
$nbrNotes = askNotes();
for ($i = 0 ; $i < $nbrNotes ; $i++) {
    $prenom = readline("Entrez le prénom : ");
    $note= (float) readline("Entrez la note : ");

    //J'ajoute dans le tableau
    $notes[] = [
        "prénom" => $prenom,
        "note" => $note
    ];
}

//Trouver la meilleure note et la plus basse
$maxNote = $notes[0];
$minNote = $notes[0];

foreach($notes as $value) {
    if($value["note"] > $maxNote["note"]) {
        $maxNote = $value;
    }
    if($value["note"] < $minNote["note"]) {
        $minNote = $value;
    }
}

echo "La meilleure note est celle de : " . $maxNote["prénom"] . " avec " . $maxNote["note"] . "\n";

echo "La plus petite appartient à : " . $minNote["prénom"] . " avec " . $minNote["note"];
