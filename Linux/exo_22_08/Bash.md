# Fiche Pratique : Scripts Bash pour Développeurs

---

## Introduction
Bash (Bourne Again SHell) est un langage de script puissant pour automatiser des tâches sous Linux/Unix. Cette fiche est conçue pour vous aider à maîtriser les bases et à progresser vers des scripts plus avancés.

---

## 1. Les Bases de Bash

### 1.1. Structure d'un Script Bash
Un script Bash commence par un **shebang** (`#!/bin/bash`) et doit être rendu exécutable avec `chmod +x script.sh`.

```bash
#!/bin/bash
# Mon premier script
echo "Bonjour, monde !"
```

### 1.2. Exécution d'un Script
```sh
chmod +x mon_script.sh
./mon_script.sh
```

---

## 2. Commandes de Base

### 2.1. Affichage et Variables

| Commande/Concept          | Description                                      | Exemple                          |
|---------------------------|--------------------------------------------------|----------------------------------|
| `echo`                    | Affiche du texte dans le terminal.               | `echo "Bonjour, monde !"`        |
| `printf`                  | Affiche du texte formaté.                        | `printf "Bonjour %s\n" "Nathan"` |
| Déclaration de variable   | Stocke une valeur dans une variable.             | `NOM="Nathan"`                   |
| Utilisation de variable   | Récupère la valeur d'une variable.               | `echo "Bonjour $NOM"`            |

---

### 2.2. Entrées Utilisateur

| Commande/Concept | Description                                      | Exemple                                      |
|------------------|--------------------------------------------------|----------------------------------------------|
| `read`           | Lit une entrée utilisateur et la stocke dans une variable. | `read -p "Entrez votre nom: " NOM`          |

---

### 2.3. Conditions

| Structure                          | Description                                      | Exemple                                                                 |
|------------------------------------|--------------------------------------------------|-------------------------------------------------------------------------|
| `if [ condition ]; then ... fi`    | Exécute un bloc de code si la condition est vraie. | `if [ "$NOM" = "Nathan" ]; then echo "Salut Nathan!"; fi`              |
| `else`                             | Exécute un bloc de code si la condition est fausse. | `if [ "$NOM" = "Nathan" ]; then echo "Salut Nathan!"; else echo "Salut inconnu!"; fi` |
| `elif`                             | Ajoute une condition supplémentaire.             | `if [ "$NOM" = "Nathan" ]; then ... elif [ "$NOM" = "Alice" ]; then ... fi` |

---

### 2.4. Boucles

| Structure                          | Description                                      | Exemple                                                                 |
|------------------------------------|--------------------------------------------------|-------------------------------------------------------------------------|
| `for i in {1..5}; do ... done`     | Boucle sur une liste ou une plage de valeurs.     | `for i in {1..5}; do echo "Itération $i"; done`                       |
| `while [ condition ]; do ... done` | Boucle tant que la condition est vraie.           | `while [ "$REPONSE" != "oui" ]; do read -p "Réessayez: " REPONSE; done` |

---

### 2.5. Fonctions

| Structure               | Description                                      | Exemple                                      |
|-------------------------|--------------------------------------------------|----------------------------------------------|
| `ma_fonction() { ... }` | Définit une fonction réutilisable.               | `saluer() { echo "Bonjour $1!"; }`          |

---

## 3. Commandes Utiles

| Commande | Description                                      | Exemple                                      |
|----------|--------------------------------------------------|----------------------------------------------|
| `grep`   | Recherche un motif dans un fichier.              | `grep "erreur" fichier.log`                 |
| `sed`    | Édite un fichier en ligne de commande.           | `sed 's/ancien/nouveau/g' fichier.txt`      |
| `awk`    | Traite des fichiers texte (colonnes, motifs).     | `awk '{print $1}' fichier.txt`              |
| `cut`    | Extrait des colonnes d'un fichier.               | `cut -d',' -f1 fichier.csv`                  |
| `sort`   | Trie les lignes d'un fichier.                    | `sort fichier.txt`                           |
| `uniq`   | Supprime les doublons dans un fichier trié.      | `sort fichier.txt | uniq`                     |
| `wc`     | Compte les mots, lignes ou caractères.           | `wc -l fichier.txt`                         |
| `find`   | Recherche des fichiers/dossiers.                 | `find /chemin -name "*.txt"`                 |
| `xargs`  | Construit et exécute des commandes à partir de l'entrée standard. | `find . -name "*.txt" | xargs rm` |

---

## 4. Exercices Pratiques

### Niveau Débutant
1. **Bonjour, Monde !**
   Écrivez un script qui demande à l'utilisateur son nom et affiche : "Bonjour, [nom] !".

2. **Calculatrice Simple**
   Écrivez un script qui demande deux nombres à l'utilisateur et affiche leur somme, différence, produit et quotient.

3. **Vérification de Fichier**
   Écrivez un script qui vérifie si un fichier existe. Si oui, affichez son contenu, sinon, créez-le.

---

### Niveau Intermédiaire
4. **Gestion des Utilisateurs**
   Écrivez un script qui crée un nouvel utilisateur sur le système (utilisez `useradd`). Le script doit vérifier si l'utilisateur existe déjà.

5. **Sauvegarde de Fichiers**
   Écrivez un script qui copie tous les fichiers `.txt` d'un répertoire source vers un répertoire de sauvegarde. Le répertoire de sauvegarde doit être créé s'il n'existe pas.

6. **Analyse de Logs**
   Écrivez un script qui compte le nombre d'occurrences du mot "erreur" dans un fichier de log et affiche le résultat.

---

### Niveau Avancé
7. **Automatisation de Déploiement**
   Écrivez un script qui :
   - Clone un dépôt Git.
   - Installe les dépendances (avec `npm` ou `pip`).
   - Lance l'application.

8. **Surveillance de Processus**
   Écrivez un script qui surveille un processus (par exemple, `nginx`). Si le processus s'arrête, le script doit le relancer automatiquement.

9. **Génération de Rapport**
   Écrivez un script qui lit un fichier CSV et génère un rapport HTML avec les données (utilisez `awk` ou un autre outil pour formater les données).

---

## 5. Bonnes Pratiques
- **Commentaires** : Ajoutez des commentaires pour expliquer les parties complexes de votre script.
- **Gestion des Erreurs** : Utilisez `set -e` pour arrêter le script en cas d'erreur.
- **Variables** : Utilisez des noms de variables explicites (ex: `NOM_UTILISATEUR` plutôt que `x`).
- **Permissions** : Limitez les permissions des scripts (`chmod 755 script.sh`).

---

## 6. Ressources Utiles
- [Guide Bash Officiel](https://www.gnu.org/software/bash/manual/)
- [Exercices Bash en Ligne](https://www.learnshell.org/)
- [Cheat Sheet Bash](https://devhints.io/bash)

---
