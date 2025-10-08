<?php
    require 'vendor/autoload.php';
    echo "Hello, World!";

    $name = "Steven";
    echo $name;
    
    const DATE = "2025-10-08";
    echo DATE;
    /*
    dump(DATE, $name); // Affiche sans stopper l'exécution
    dd(DATE, $name); // Affiche et stoppe l'exécution
    */

    $nb1 = 10;
    $nb2 = 5;
    if($nb1 > $nb2) {
        echo "$nb1 est plus grand que $nb2";
    } elseif($nb1 < $nb2) {
        echo "$nb1 est plus petit que $nb2";
    } else {
        echo "$nb1 est égal à $nb2";
    }

    nom(25, "Bonjour");
    function nom (int $age, string $text) : string|array{
        return [$age, $text];
}
?>
<br>
<?php
   //Exercices 1 à 3 :
    /*
Exercice 1 :
-Créer une fonction qui affiche la valeur la plus grande du tableau.
*/
    $tab = [10,33,-5,26,52,47,896,123,1,-24,76,25];
    function maxTab(array $tab) : int {
        $max = $tab[0];
        foreach($tab as $value) {
            if($value > $max) {
                $max = $value;
            }
        }
        return $max;
    }
    echo maxTab($tab);
/*
Exercice 2 :
-Créer une fonction qui affiche la moyenne du tableau.
*/
    function moyenneTab(array $tab) : float {
        $somme = 0;
        foreach($tab as $value) {
            $somme += $value;
        }
        return $somme / count($tab);
    }
    echo "<br>" . moyenneTab($tab);
?>
    <p>------------------------</p>
<?php
/*
Exercice 3 :
-Créer une fonction qui affiche la valeur la plus petite du tableau.
*/
    function minTab(array $tab) : int {
        $min = [0];
        foreach($tab as $value) {
            if($value <$min) {
                $min = $value;
            }
        }
        return $min;
    }
    echo minTab($tab);

    $notes = [];
    $test = readline("Combien de notes voulez-vous entrer ? ");
