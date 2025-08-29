# 🐳 Fiche d’exercices Docker & Docker Compose

## Partie 1 – Découverte de Docker

### 1. Hello World avec Docker
- Lancer :  
  ```bash
  docker run hello-world
  ```
- Lire et comprendre le message affiché.

---

### 2. Lister et gérer les conteneurs
- Lister les conteneurs en cours :  
  ```bash
  docker ps
  ```
- Lister tous les conteneurs (même arrêtés) :  
  ```bash
  docker ps -a
  ```
- Supprimer un conteneur arrêté :  
  ```bash
  docker rm <id>
  ```

---

### 3. Lancer un serveur web simple
- Démarrer Nginx :  
  ```bash
  docker run -d -p 8080:80 nginx
  ```
- Tester sur : http://localhost:8080  
- Arrêter avec :  
  ```bash
  docker stop <id>
  ```

---

## Partie 2 – Dockerfile

### 4. Mon premier Dockerfile (Hello World en HTML)
- Créer `index.html` :
  ```html
  <h1>Hello Docker !</h1>
  ```
- Créer `Dockerfile` :
  ```dockerfile
  FROM nginx
  COPY index.html /usr/share/nginx/html/index.html
  ```
- Construire l’image :  
  ```bash
  docker build -t mon-site .
  ```
- Lancer le conteneur :  
  ```bash
  docker run -d -p 8080:80 mon-site
  ```

---

### 5. Conteneur Python simple
- Créer `app.py` :
  ```python
  print("Bonjour depuis Docker !")
  ```
- Créer `Dockerfile` :
  ```dockerfile
  FROM python:3.9
  COPY app.py /app/app.py
  WORKDIR /app
  CMD ["python", "app.py"]
  ```
- Construire et exécuter :
  ```bash
  docker build -t python-app .
  docker run python-app
  ```

---

### 6. Volumes : persister les données
- Lancer un conteneur avec volume :
  ```bash
  docker run -it -v $(pwd)/data:/data alpine sh
  ```
- Dans le conteneur :
  ```bash
  echo "test" > /data/fichier.txt
  ```
- Vérifier sur l’hôte que `data/fichier.txt` existe.

---

### 7. Variables d’environnement
- Créer `Dockerfile` :
  ```dockerfile
  FROM alpine
  ENV NOM=Etudiant
  CMD echo "Bonjour $NOM depuis Docker !"
  ```
- Construire et exécuter :  
  ```bash
  docker build -t mon-image .
  docker run mon-image
  docker run -e NOM="Alice" mon-image
  ```

---

## Partie 3 – Docker Compose

### 8. Premier docker-compose.yml (Nginx simple)
- Créer `docker-compose.yml` :
  ```yaml
  version: "3.9"
  services:
    web:
      image: nginx
      ports:
        - "8080:80"
  ```
- Lancer :
  ```bash
  docker compose up -d
  ```
- Tester sur http://localhost:8080  
- Arrêter :
  ```bash
  docker compose down
  ```

---

### 9. Compose avec un Dockerfile (site perso)
- Reprendre le projet **site HTML + Dockerfile**.  
- Créer `docker-compose.yml` :
  ```yaml
  version: "3.9"
  services:
    web:
      build: .
      ports:
        - "8080:80"
  ```
- Lancer :  
  ```bash
  docker compose up -d
  ```
- Modifier `index.html`, reconstruire avec :  
  ```bash
  docker compose up -d --build
  ```

---

### 10. Compose avec plusieurs services (app + base de données)
- Créer `docker-compose.yml` :
  ```yaml
  version: "3.9"
  services:
    db:
      image: mysql:5.7
      environment:
        MYSQL_ROOT_PASSWORD: root
        MYSQL_DATABASE: demo
      ports:
        - "3306:3306"

    app:
      build: .
      depends_on:
        - db
  ```
- Créer `Dockerfile` :
  ```dockerfile
  FROM python:3.9
  COPY app.py /app/app.py
  WORKDIR /app
  CMD ["python", "app.py"]
  ```
- Créer `app.py` :
  ```python
  print("Application connectée à MySQL (simulation)")
  ```
- Lancer :  
  ```bash
  docker compose up -d
  ```

---

### 11. Volumes et persistance avec Compose
- Ajouter un volume pour MySQL :
  ```yaml
  version: "3.9"
  services:
    db:
      image: mysql:5.7
      environment:
        MYSQL_ROOT_PASSWORD: root
        MYSQL_DATABASE: demo
      ports:
        - "3306:3306"
      volumes:
        - db_data:/var/lib/mysql

  volumes:
    db_data:
  ```
- Vérifier que la base persiste après `docker compose down` puis relance.

---

### 12. Variables d’environnement avec `.env`
- Créer `.env` :
  ```
  MYSQL_ROOT_PASSWORD=root
  MYSQL_DATABASE=demo
  ```
- Modifier `docker-compose.yml` :
  ```yaml
  version: "3.9"
  services:
    db:
      image: mysql:5.7
      environment:
        MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
        MYSQL_DATABASE: ${MYSQL_DATABASE}
      ports:
        - "3306:3306"
  ```

---

✅ Avec cette fiche, vous apprendrez à :  
- Manipuler des conteneurs simples  
- Écrire vos premiers Dockerfile  
- Persister des données et utiliser des variables  
- Construire une stack multi-services avec Docker Compose
