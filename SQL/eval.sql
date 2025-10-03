CREATE DATABASE jeucombat;
USE jeucombat;

-- Création des Tables
CREATE TABLE joueurs(
	id_joueurs INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    pseudo_joueur VARCHAR(50) NOT NULL UNIQUE,
    mdp_joueur VARCHAR(150) NOT NULL,
    mail_joueur VARCHAR(100) NOT NULL UNIQUE,
    id_carnet_amis INT
)ENGINE = innoDB;

CREATE TABLE carnet_amis(
	id_carnet_amis INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_carnet VARCHAR(50) NOT NULL
)ENGINE = innoDB;

CREATE TABLE contenir(
	id_joueurs INT,
    id_carnet_amis INT
)ENGINE = innoDB;

CREATE TABLE messages(
	id_messages INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    date_message DATETIME NOT NULL,
    sujet VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    id_auteur INT,
    id_destinataire INT
)ENGINE = innoDB;

CREATE TABLE costume(
	id_costume INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_costume VARCHAR(50) NOT NULL UNIQUE
)ENGINE = innoDB;

CREATE TABLE personnage(
	id_personnage INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_personnage VARCHAR(50) NOT NULL UNIQUE,
    id_type_personnage INT,
    id_joueurs INT
)ENGINE = innoDB;

CREATE TABLE achat(
	id_achat INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    date_achat DATETIME NOT NULL,
    id_personnage INT,
    id_costume INT,
    id_joueurs INT
)ENGINE = innoDB;

CREATE TABLE type_personnage(
	id_type_personnage INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    type_personnage VARCHAR(50) NOT NULL UNIQUE,
    attaque INT NOT NULL,
    point_de_vie INT NOT NULL,
    defense INT NOT NULL
)ENGINE = innoDB;

CREATE TABLE item(
	id_item INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_item VARCHAR(50) NOT NULL UNIQUE,
    bonus_attaque INT NOT NULL,
    bonus_point_de_vie INT NOT NULL,
    bonus_defense INT NOT NULL
)ENGINE = innoDB;

CREATE TABLE obtenir(
	equipe BOOL,
	id_item INT,
    id_personnage INT
)ENGINE = innoDB;

CREATE TABLE arene(
	id_arene INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_arene VARCHAR(50) NOT NULL
)ENGINE = innoDB;

CREATE TABLE combats(
	id_combat INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    date_combat DATETIME NOT NULL,
    id_arene INT,
    id_vaincu INT,
    id_vainqueur INT
)ENGINE = innoDB;

-- Création des clés étrangères
ALTER TABLE contenir ADD CONSTRAINT FOREIGN KEY (id_joueurs) REFERENCES joueurs(id_joueurs);
ALTER TABLE contenir ADD CONSTRAINT FOREIGN KEY (id_carnet_amis) REFERENCES carnet_amis(id_carnet_amis);
ALTER TABLE joueurs ADD CONSTRAINT FOREIGN KEY (id_carnet_amis) REFERENCES carnet_amis(id_carnet_amis);
ALTER TABLE messages ADD CONSTRAINT FOREIGN KEY (id_auteur) REFERENCES joueurs(id_joueurs);
ALTER TABLE messages ADD CONSTRAINT FOREIGN KEY (id_destinataire) REFERENCES joueurs(id_joueurs);
ALTER TABLE achat ADD CONSTRAINT FOREIGN KEY (id_personnage) REFERENCES personnage(id_personnage);
ALTER TABLE achat ADD CONSTRAINT FOREIGN KEY (id_costume) REFERENCES costume(id_costume);
ALTER TABLE achat ADD CONSTRAINT FOREIGN KEY (id_joueurs) REFERENCES joueurs(id_joueurs);
ALTER TABLE obtenir ADD CONSTRAINT FOREIGN KEY (id_personnage) REFERENCES personnage(id_personnage);
ALTER TABLE obtenir ADD CONSTRAINT FOREIGN KEY (id_item) REFERENCES item(id_item);
ALTER TABLE personnage ADD CONSTRAINT FOREIGN KEY (id_joueurs) REFERENCES joueurs(id_joueurs);
ALTER TABLE personnage ADD CONSTRAINT FOREIGN KEY (id_type_personnage) REFERENCES type_personnage(id_type_personnage);
ALTER TABLE combats ADD CONSTRAINT FOREIGN KEY (id_vaincu) REFERENCES personnage(id_personnage);
ALTER TABLE combats ADD CONSTRAINT FOREIGN KEY (id_vainqueur) REFERENCES personnage(id_personnage);
ALTER TABLE combats ADD CONSTRAINT FOREIGN KEY (id_arene) REFERENCES arene(id_arene);

-- Insertion des données
INSERT INTO type_personnage (type_personnage, point_de_vie, defense, attaque)
	VALUES ("Barbare", 125, 5, 15),
    	("Guerrier", 100, 10, 10),
    	("Chevalier", 75, 15, 5);

INSERT INTO  arene (nom_arene)
	VALUES ("Colisée"),
    	("Muraille"),
    	("Armurerie");

INSERT INTO item (nom_item, bonus_point_de_vie, bonus_defense, bonus_attaque)
	VALUES ("Arme de base", 0, 0, 0),
		("Bouclier de la Méduse", 25, 15, 10),
    	("Marteau de Thor", 25, 5, 20),
    	("Excalibur", 20, 10, 20),
    	("Egide", 20, 30, 0),
    	("Sainte Lance", 10, 10, 30);

INSERT INTO costume (nom_costume)
	VALueS ("La Faucheuse"),
    	("Le Lapin de Pâque"),
		("La Banshee"),
		("Jeanne d'Arc"),
    	("Phénix");

INSERT INTO carnet_amis (nom_carnet)
	VALUES ("Ma Liste"),
    	("Mes Amis"),
		("Super Friends"),
		("The Crew"),
		("Famille de Coeur");

INSERT INTO joueurs (pseudo_joueur, mdp_joueur, mail_joueur, id_carnet_amis)
	VALUES ("Dark Schneider","12345","dark.s@gmail.com",1),
    	("Perceval","Kaamelott31","alexast@sfr.fr",2),
    	("Guts","berserker#666","ceska@orange.fr",3),
    	("Broly","cacarot974","guillaume@gmail.com",4),
    	("Suskiki666","NarutoIsTheBest","hinatainlove@sfr.fr",5);

INSERT INTO personnage (nom_personnage, id_joueurs, id_type_personnage)
	VALUES ("Power Killer",1,1),
    	("Mordred",2,3),
    	("Griffith",3,3),
    	("Vegeta",4,2),
    	("Kakashi",5,2),
    	("Bohort",2,1),
    	("Lars",1,3);

INSERT INTO combats (date_combat, id_arene, id_vainqueur, id_vaincu)
	VALUES ("2022-06-23",1,1,2),
    	("2022-06-23",2,3,2),
    	("2022-07-01",3,6,5),
    	("2022-07-13",1,5,7),
    	("2022-07-15",1,4,1),
		("2022-07-17",1,4,1);

INSERT INTO obtenir (id_item, id_personnage, equipe)
	VALUES (6,1,false),
    	(6,2,false),
    	(6,3,false),
    	(6,4,false),
    	(6,5,false),
    	(6,6,true),
    	(6,7,true),
    	(1,1,true),
    	(2,1,false),
    	(3,2,true),
    	(4,3,true),
    	(5,4,true),
    	(1,5,true),
    	(3,3,false),
    	(4,1,false);

INSERT INTO contenir (id_carnet_amis, id_joueurs)
	VALUES (3,1),
		(1,3),
    	(3,2),
		(2,3),
		(1,4),
		(4,1),
    	(4,5),
		(5,4),
    	(5,2),
		(2,5),
		(5,3),
		(3,5);

INSERT INTO messages (id_auteur, id_destinataire, date_message, sujet, message)
	VALUES (1,3, "2022-06-21","Hey","Salut bro ! Comment tu vas ?"),
    	(3,1, "2022-06-21", "Re:Hey","Salut poto ! Ca va super. C'est l'éclate ce jeu. :D"),
    	(1,3, "2022-06-22", "ReRe:Hey","Ha ha, t'as vu, je te l'avais dis. Heureusement que je t'ai bassiné avec pendant des plombes. ;)"),
    	(3,1, "2022-06-22", "ReReRe:Hey","J'avoue XD  Au passage, je viens de me payer la tenue de Jeane D'Arc. Tu sais, la version Fate Apocryphe"),
    	(1,2, "2022-06-23", "Salut","Coucou toi. Je savais que t'étais sur le jeu. Comment tu vas"),
    	(2,3, "2022-06-23", "Dis, t'aurais pas gaffé","Hé toi, par hasard, t'aurai pas dit à ton pote que j'étais sur le jeu. Non parce que ce relou vient de m'envoyer un message.");
        
-- Modification de la BDD
ALTER TABLE costume 
	ADD COLUMN prix DECIMAL (10,2);
    
UPDATE costume SET prix = 20 WHERE nom_costume = "La Faucheuse";
UPDATE costume SET prix = 35 WHERE nom_costume = "Le Lapin de Pâque";
UPDATE costume SET prix = 35 WHERE nom_costume = "Phénix";
UPDATE costume SET prix = 15.50 WHERE nom_costume = "La Banshee";
UPDATE costume SET prix = 29.50 WHERE nom_costume = "Jeanne d'Arc";

INSERT INTO achat (date_achat,id_joueurs,id_costume, id_personnage) VALUES    
	("2022-05-10",1,1,1),
	("2022-06-01",1,2,7),
	("2022-06-21",3,4,3),
	("2022-06-21",1,3,1),
	("2022-06-23",3,5,3),
	("2022-07-03",5,1,5);
    
-- Consultation des données
-- 1)
SELECT pseudo_joueur
FROM joueurs;

-- 2)
SELECT pseudo_joueur, mail_joueur
FROM joueurs
WHERE id_joueurs = 3;

-- 3)
SELECT j.pseudo_joueur, p.nom_personnage
FROM joueurs j
INNER JOIN personnage p ON j.id_joueurs = p.id_joueurs
WHERE j.id_joueurs = 1;

-- 4)
SELECT j.pseudo_joueur, c.nom_costume, p.nom_personnage
FROM joueurs j
JOIN achat a ON j.id_joueurs = a.id_joueurs
JOIN costume c ON a.id_costume = c.id_costume
JOIN personnage p ON a.id_personnage = p.id_personnage
WHERE j.id_joueurs = 1;

-- 5)
SELECT j.pseudo_joueur, SUM(c.prix)
FROM joueurs j
INNER JOIN achat a ON j.id_joueurs = a.id_joueurs
INNER JOIN costume c ON c.id_costume = a.id_costume
GROUP BY j.id_joueurs
ORDER BY j.id_joueurs DESC;

-- 6)
SELECT j.pseudo_joueur, group_concat(h.pseudo_joueur SEPARATOR' / ')
FROM joueurs j 
INNER JOIN carnet_amis ca ON ca.id_carnet_amis = j.id_carnet_amis
INNER JOIN contenir c ON c.id_carnet_amis = ca.id_carnet_amis
INNER JOIN joueurs h ON h.id_joueurs= c.id_joueurs
WHERE j.id_joueurs = 3;


-- 7)
SELECT m.date_message, j.pseudo_joueur auteur, m.sujet, m.message, 'envoyés' type
FROM joueurs j
INNER JOIN messages m ON m.id_auteur = j.id_joueurs
WHERE j.id_joueurs = 3
UNION ALL
SELECT m.date_message, j.pseudo_joueur auteur, m.sujet, m.message, 'reçu' type
FROM joueurs j
INNER JOIN messages m ON m.id_destinataire = j.id_joueurs
WHERE j.id_joueurs = 3;

-- 8)
SELECT j.pseudo_joueur, c.date_combat, a.nom_arene, p1.nom_personnage vainqueur ,'vainqueur' type
FROM joueurs j
INNER JOIN personnage p ON j.id_joueurs = p.id_joueurs
INNER JOIN combats c ON p.id_personnage = c.id_vainqueur
INNER JOIN arene a ON c.id_arene = a.id_arene
INNER JOIN personnage p1 ON c.id_vainqueur = p1.id_personnage
WHERE p.id_joueurs = 1
UNION ALL
SELECT j.pseudo_joueur, c.date_combat, a.nom_arene, p2.nom_personnage vaincu, 'vaincu' type
FROM joueurs j
INNER JOIN personnage p ON j.id_joueurs = p.id_joueurs
INNER JOIN combats c ON p.id_personnage = c.id_vaincu
INNER JOIN arene a ON c.id_arene = a.id_arene
INNER JOIN personnage p2 ON c.id_vaincu = p2.id_personnage
WHERE p.id_joueurs = 1;

-- SUPPRESSION DE DONNEES
-- 10)
DELETE FROM achat
WHERE id_joueurs = 1;
DELETE FROM obtenir
WHERE id_personnage = 1;
DELETE FROM combats
WHERE id_vainqueur = 1;
DELETE FROM combats
WHERE id_vaincu = 1;
DELETE FROM personnage
WHERE id_personnage = 1;

-- 11)
DELETE FROM messages
WHERE id_auteur = 2;
DELETE FROM messages
WHERE id_destinataire = 2;
DELETE FROM contenir
WHERE id_joueurs = 2;
DELETE FROM obtenir
WHERE id_personnage = 2;
DELETE FROM obtenir
WHERE id_personnage = 6;
DELETE FROM combats
WHERE id_vaincu = 2;
DELETE FROM combats
WHERE id_vainqueur = 6;
DELETE FROM personnage
WHERE id_joueurs = 2;
DELETE FROM joueurs
WHERE id_joueurs = 2;


