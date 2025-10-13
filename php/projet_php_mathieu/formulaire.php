<?php
include 'vendor/autoload.php';
//! EXO 1
$resultat = '';
if(isset($_POST['submit'])){
    if (!empty($_POST['prixHT']) && isset($_POST['prixHT'])&&
        (!empty($_POST['quantite'])) && isset($_POST['quantite']) &&
        (!empty($_POST['tva'])) && isset($_POST['tva'])){
            $prixHt = $_POST['prixHT'];
            $quantite = $_POST['quantite'];
            $tva = $_POST['tva'];
            $resultatTva = $prixHt * (1 +$tva/100) * $quantite;
            $resultat = "<p>Le prix TTC est égal à : " .  $resultatTva .  " €. ";
        }else{
            $resultat= "<p style='color:red; text-align: center'>Merci de remplir les champs avec des nombres !</p>";
        }
        
}

//! EXO 2
$resultat1 = '';
if(isset($_POST['submitOp'])){
    $resultat1 = operator();
}

function operator() {
    if (
        !isset($_POST["nbr1"], $_POST["nbr2"], $_POST["operateur"]) ||
        $_POST["nbr1"] === '' || $_POST["nbr2"] === '' || $_POST["operateur"] === ''
    ) {
        return "Veuillez remplir tous les champs.";
    }

    if (!is_numeric($_POST["nbr1"]) || !is_numeric($_POST["nbr2"])){
        return "Veuillez saisir des nombres.";
    }
    $nb1 = $_POST["nbr1"];
    $nb2 = $_POST["nbr2"];
    $operateur = trim($_POST["operateur"]);
    
    $op_valides = ['+', '-', '*', '/'];
    if (!in_array($operateur, $op_valides)){
        return "Opérateur non recconu.";
    }

    switch($operateur) {

        case "+":
            return $nb1 + $nb2;
            break;

        case "-":
            return $nb1 - $nb2;
            break;

        case "*":
            return $nb1 * $nb2;
            break;

        case "/":
            if ($nb2 == 0){
                return "Division par 0 impossible";
            }
            return $nb1 / $nb2;
            break;

            default:
            return "erreur";
            break;
    }
    return $resultat1;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div>
        <h1>exo 1</h1>

        <form action="" method="post">
            <label for="prixHT">Prix HT :</label>
            <input type="number" name="prixHT" id="prixHT" step="0.01" required>
            <br>

            <label for="quantite">Quantité :</label>
            <input type="number" name="quantite" id="quantite" required>
            <br>

            <label for="tva">TVA :</label>
            <input type="number" name="tva" id="tva" required>

            <input type="submit" value="Calculer" name="submit">

            <p><?= $resultat??""?></p>
        </form>
        <p>---------------------------------</p>
    </div>

    <div>
        <h2>exo 2</h2>

        <form action="" method="post">  
            <label for="nbr1">Saisir un nombre</label>
            <input type="text" name="nbr1">
            <br>

            <label for="nbr2">Saisir un nombre</label>
            <input type="text" name="nbr2">
            <br>

            <label for="operateur">Saisir un opérateur mathémathique: </label>
            <input type="text" name="operateur">

            <input style="text-align: center;" type="submit" value="calculer" name="submitOp">
            <p><?= $resultat1??"" ?></p>
        </form>
    </div>
</body>
</html>