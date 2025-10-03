CREATE DATABASE IF NOT EXISTS ticket CHARSET utf8mb4;
USE ticket;
/*Création d'une table*/

CREATE TABLE IF NOT EXISTS seller(
	id_seller INT PRIMARY KEY AUTO_INCREMENT,
    firstname_seller VARCHAR(50) NOT NULL,
    lastname_seller VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
)ENGINE=innoDB;

CREATE TABLE IF NOT EXISTS ticket(
	id_ticket INT PRIMARY KEY AUTO_INCREMENT,
    date_ticket DATETIME NOT NULL,
    id_seller INT NOT NULL,
    CONSTRAINT fk_ticket_seller FOREIGN KEY (id_seller) REFERENCES seller(id_seller) ON DELETE CASCADE
)ENGINE=innoDB;

CREATE TABLE IF NOT EXISTS consumner(
	id_consumner INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(50) NOT NULL, 
    lastname VARCHAR(50) NOT NULL
)ENGINE=innoDB;

CREATE TABLE IF NOT EXISTS article (
	id_article INT PRIMARY KEY AUTO_INCREMENT,
    name_article VARCHAR(50)
)ENGINE=innodb;

CREATE TABLE IF NOT EXISTS ticket_article (
	id_ticket INT,
    id_article INT,
    PRIMARY KEY (id_ticket, id_article),
    FOREIGN KEY (id_ticket) REFERENCES ticket(id_ticket) ON DELETE CASCADE,
    FOREIGN KEY (id_article) REFERENCES article(id_article) ON DELETE CASCADE
) ENGINE=InnoDB;

-- altération /modification de la structure de la table
ALTER TABLE ticket ADD COLUMN id_consumner INT NOT NULL;

-- Ajout d'une contrainte
ALTER TABLE ticket ADD CONSTRAINT fk_ticket_consumner
	FOREIGN KEY (id_consumner) REFERENCES consumner(id_consumner) ON DELETE CASCADE;

ALTER TABLE article 
	ADD COLUMN price DECIMAL(10.2) NOT NULL;
    


ALTER TABLE ticket_article
	ADD COLUMN quantite INT NOT NULL;

-- Supprimer ma contrainte de clé étrangère
-- ALTER TABLE ticket DROP CONSTRAINT fk_ticket_consumner

-- Modifier une colonne
ALTER TABLE seller MODIFY age INT NOT NULL DEFAULT 16;
	
-- Modifier nom d'une colonne
ALTER TABLE seller CHANGE dob day_of_born DATE NOT NULL;

-- Modifier nom d'une table
RENAME TABLE consumner TO buyer;

-- Suppression
-- DROP TABLE ticket_article;

-- Supprimer une colonne
-- ALTER TABLE article DROP COLUMN price;

-- ENREGISTREMENT DE DONNEES
-- 2 syntaxes
INSERT INTO seller VALUES (1, "Steven", "Sarkozy", 50, "2025-02-12", "stevenprez@gay.com");

INSERT INTO seller (age, day_of_born, lastname_seller, firstname_seller, email) 
VALUES (23, "2002-12-03", "Zidane", "Zinedine", "zz@zz.com"),
	(900, "1125-12-01", "Yoda", "Grogu", "yoda@yoda.com"),
    (30, "1995-01-01", "Henry", "Thierry", "thierry-henry@gmail.com");
    
INSERT INTO seller (age, day_of_born, lastname_seller, firstname_seller, email) 
    VALUES (54, "1970-12-12", "Henry", "Thierry", "tt@gmail.com");
INSERT INTO seller (age, day_of_born, lastname_seller, firstname_seller, email) 
    VALUES (54, "1970-12-12", "L'bogoss", "Maurice", "t@gmail.com");
INSERT INTO seller (age, day_of_born, lastname_seller, firstname_seller, email) 
    VALUES (20, "2005-12-12", "House", "Antoine", "aaa@gmail.com");
    
INSERT INTO article (name_article, price)
VALUES ("dentifrice", 10), 
	("PS5", 450),
    ("chocolat", 1000),
    ("du déo tkt", 12.5),
    ("télé trop chère pour toi",80);

INSERT INTO consumner (firstname, lastname)
VALUES ("BARTHEZ", "Fabien"),
	("Dr", "Dre"),
    ("Chirac", "Jacques"),
    ("Bellic", "Niko"),
    ("Mbappe", "Kyllian"),
    ("Jordan", "Mickael"),
    ("Longoria", "Eva");
    
INSERT INTO ticket (date_ticket, id_seller, id_consumner)
VALUES ("2025-10-01 14:00:00", 1, 1),
	("2025-01-01 10:00:00", 2, 2),
	("2025-08-12 09:54:20", 3, 3),
    ("2025-09-08 15:41:56", 4, 4),
    ("2025-04-14 21:14:14", 5, 5),
    ("2025-10-01 14:00:00", 6, 6),
	("2025-01-01 10:00:00", 1, 7),
	("2025-08-12 09:54:20", 2, 1),
    ("2025-09-08 15:41:56", 3, 2),
    ("2025-04-14 21:14:14", 4, 3);
    

INSERT INTO ticket_article(id_ticket, id_article, quantite)
VALUES (1, 1, 1),
	(2, 2, 10),
    (3, 3, 5),
    (4, 4, 8),
    (5, 5, 15),
    (6, 1, 1),
	(7, 2, 10),
    (8, 3, 18),
    (9, 4, 54),
    (10, 5, 17);
    
   /* 
-- Mise à jour des données
UPDATE article set price = 24.90;
UPDATE article set price = 1000 WHERE id_article =1;

-- MAJ nom et prenom vendeur
UPDATE seller SET firstname_seller = "Didier", lastname_seller = "Drogba"
	WHERE firstname_seller = "Steven" AND lastname_seller = "Sarkozy";

-- Suppression
/*
DELETE FROM ticket_article; -- -> supprime tous les ticket
DELETE FROM ticket_article WHERE id_ticket =1 AND id_article = 1;

-- Suppression de toutes les donnée d'une table avec réinitialisation du décompte de clé primaire
TRUNCATE seller;

Truncate : ne fonctionne pas sur des tables qui sont liés à une clé étrangère
*/

/*
UPDATE seller SET age = 20 WHERE id_seller =1;
UPDATE article SET price = 58 WHERE id_article =3;
UPDATE buyer SET firstname = "Addams", lastname = "Gomez"
	WHERE firstname = "Chirac" AND lastname = "Jacques";
    
UPDATE ticket_article SET id_article = 5 WHERE id_ticket = 2;

DELETE FROM ticket_article WHERE id_ticket = 5;

DELETE FROM article WHERE id_article = 5;
TRUNCATE seller;
 /*
-- REQUETE DE LECTURE : SELECT
SELECT id_article, name_article FROM article;
SELECT * FROM article;

-- ALIAS : AS
SELECT a.id_article, a.name_article, a.price FROM article AS a;

-- DISTINCT : permet de supprimer les données en doublons
SELECT s.firstname_seller, s.lastname_seller FROM seller AS s;
SELECT DISTINCT s.firstname_seller, s.lastname_seller FROM seller AS s;

-- CONDITION : WHERE
-- IN : un champ dont la valeur correspond à une des valeurs d'un tableau
SELECT s.firstname_seller, s.lastname_seller, s.age FROM seller AS s
	WHERE s.age IN (13,15,900);
    
-- BETWEEN ... AND. Valeurs numériques et alphabétique
SELECT s.firstname_seller, s.lastname_seller, s.age FROM seller AS s
	WHERE s.age BETWEEN 13 AND 900;
SELECT s.firstname_seller, s.lastname_seller, s.age FROM seller AS s
	WHERE s.lastname_seller BETWEEN "A" AND "ZZ";
    
-- LIKE : formate une chaine de caractère
SELECT s.firstname_seller, s.lastname_seller, s.age FROM seller AS s
	WHERE s.lastname_seller LIKE "Z%";
    
-- ORDER BY : classe les données dans un ordre croissant ou décroissant
SELECT s.firstname_seller, s.lastname_seller, s.age FROM seller AS s
	ORDER BY s.firstname_seller ASC;
    
SELECT s.id_seller, s.firstname_seller, s.lastname_seller, s.age FROM seller AS s
	ORDER BY s.firstname_seller DESC, s.age DESC;
    */
    
    /*
-- 1
SELECT a.name_article FROM article AS a;
-- 2
SELECT s.firstname_seller , s.lastname_seller FROM seller AS s;
-- 3
SELECT a.name_article FROM article AS a
	WHERE a.price > 50;
-- 4
SELECT a.name_article FROM article AS a
	WHERE a.price <= 20;
-- 5
SELECT s.firstname_seller FROM seller AS s
	WHERE s.age > 40 AND s.email LIKE "%a%";
-- 6
SELECT s.firstname_seller FROM seller AS s
	WHERE s.age > 40 AND s.email LIKE "%a%" 
    ORDER BY s.lastname_seller DESC;
-- 7
SELECT a.name_article FROM article AS a
	WHERE a.name_article LIKE "ba%" 
    OR a.name_article like "%'%"
    OR a.price IN (15,24,90,300,55,1000);
-- 8
SELECT s.firstname_seller, s.lastname_seller FROM seller AS s
	WHERE id_seller LIKE 1 
    OR s.firstname_seller >= "Maurice";
    
    
-- FONCTION D'AGREGATION (ou fonction de calcul) :
-- AVG() : calcul la moyenne d'un jeu de donné
SELECT avg(article.price) FROM article; -- -> calcul le prix moyen de l'ensemble de mes articles

-- COUNT() : calcul le nombre de ligne dans un jeu de donné
SELECT count(article.name_article) FROM article; -- -> calcul le nombre de noms différent parmi mes articles

SELECT count(article.id_article) FROM article; -- -> calcul le nombre d'article dans ma BDD

-- MAX() : sort le plus grand
SELECT max(article.price) FROM article; -- -> calcul le prix maximum parmi mes articles

-- GROUP BY : regroupe les données selon un champ, avant d'effectuer le calcul demandée
SELECT avg(article.price) FROM article GROUP BY article.commerce; -- -> calculer le prix moyen pour chaque commerce
SELECT article.commerce, avg(article.price) FROM article GROUP BY article.commerce;

SELECT count(article.id_article) FROM article GROUP BY article.commerce; -- -> calculer le nombre d'article vendu par chaque commerce
SELECT article.commerce, count(article.id_article) FROM article GROUP BY article.commerce;

-- -> Calculer le nombre d'objet vendu par chaque commerce, ainsi que leur prix moyen
SELECT article.commerce, count(article.id_article), avg(article.price) FROM article GROUP BY article.commerce;

-- HAVING : condition appliquée sur les fonction d'aggrégation
SELECT article.commerce, count(article.id_article), avg(article.price) FROM article GROUP BY article.commerce
    HAVING count(article.id_article) < 3;
*/
-- 2
SELECT count(id_seller) FROM seller;

-- 3
SELECT count(id_ticket) FROM ticket;

-- 4
SELECT id_seller, count(id_ticket)
FROM ticket
GROUP BY id_seller;

-- 5
SELECT id_article, avg(quantite)
FROM ticket_article
GROUP BY id_article;

-- 6
SELECT id_ticket, avg(quantite)
FROM ticket_article
GROUP BY id_ticket;

-- 7
SELECT id_article, sum(quantite)
FROM ticket_article;

-- 8
SELECT id_ticket, sum(quantite)
FROM ticket_article
GROUP BY id_ticket;

-- 9
SELECT id_ticket, id_seller, max(date_ticket)
FROM ticket;

-- 10
SELECT avg(age)
FROM seller;

-- 11
SELECT sum(price)
FROM article;

-- 12
SELECT id_ticket, sum(quantite)
FROM ticket_article
GROUP BY id_ticket 
HAVING sum(quantite) >10;

-- 13
SELECT id_article, max(quantite)
FROM ticket_article
GROUP BY id_article
HAVING max(quantite) =1;

-- 14
SELECT id_seller, count(id_consumner)
FROM ticket
GROUP BY id_seller
HAVING count(id_consumner) < 2;

-- FONCTION GROUP_CONCAT: concatène les données d'un champs sur une ligne

SELECT * FROM article ORDER BY name_article;
SELECT name_article, group_concat(price SEPARATOR" / ") FROM article GROUP BY name_article;

SELECT id_ticket, group_concat(id_article) FROM ticket_article GROUP BY id_ticket;
SELECT group_concat(name_article), group_concat(price) FROM article;


-- INNER JOIN  
SELECT s.firstname_seller, s.lastname_seller, t.date_ticket
FROM seller AS s
INNER JOIN ticket AS t ON s.id_seller = t.id_seller;

SELECT s.firstname_seller, s.lastname_seller, group_concat(t.date_ticket SEPARATOR " / ") 
FROM seller AS s
INNER JOIN ticket AS t ON s.id_seller = t.id_seller
GROUP BY s.id_seller;

-- 1
SELECT c.lastname, c.firstname, group_concat(t.date_ticket SEPARATOR " - ") 
FROM consumner AS c
INNER JOIN ticket AS t ON c.id_consumner = t.id_consumner
GROUP BY c.lastname;

-- 2
SELECT t.id_ticket, group_concat(a.name_article SEPARATOR " - ")
FROM ticket AS t
INNER JOIN ticket_article AS ta ON t.id_ticket = ta.id_ticket
INNER JOIN article AS a ON ta.id_article = a.id_article
GROUP BY t.id_ticket;

-- 3
SELECT s.lastname_seller, s.firstname_seller, group_concat(DISTINCT a.name_article SEPARATOR " / ")
FROM seller AS s
INNER JOIN ticket AS t ON s.id_seller = t.id_seller
INNER JOIN ticket_article AS ta ON t.id_ticket = ta.id_ticket
INNER JOIN article AS a ON ta.id_article = a .id_article
GROUP BY s.lastname_seller;

-- 4
SELECT t.id_ticket, t.date_ticket, sum(a.price *ta.quantite) 
FROM ticket AS t
INNER JOIN ticket_article AS ta ON t.id_ticket = ta.id_ticket
INNER JOIN article AS a ON ta.id_article = a.id_article
GROUP BY t.id_ticket, t.date_ticket;

-- 5
SELECT group_concat(s.firstname_seller, ' - ', s.lastname_seller), c.lastname, c.firstname, t.date_ticket, group_concat(a.name_article SEPARATOR " / ") , a.price
FROM seller s
INNER JOIN ticket t ON s.id_seller = t.id_seller
INNER JOIN consumner c ON t.id_consumner = c.id_consumner
INNER JOIN ticket_article ta ON t.id_ticket = ta.id_ticket
INNER JOIN article a ON ta.id_article = a.id_article
GROUP BY t.id_ticket;

-- LEFT ET RIGHT JOIN
SELECT s.firstname_seller, s.lastname_seller, group_concat(t.date_ticket SEPARATOR ' / ') 
FROM seller AS s
LEFT JOIN ticket t ON s.id_seller = t.id_seller
GROUP BY s.id_seller
HAVING group_concat(t.date_ticket SEPARATOR ' / ') IS NULL;