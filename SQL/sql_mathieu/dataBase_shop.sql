CREATE DATABASE IF NOT EXISTS shop CHARSET utf8mb4;
USE shop;

CREATE TABLE IF NOT EXISTS category(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(50) NOT NULL UNIQUE
)ENGINE= InnoDB;

CREATE TABLE IF NOT EXISTS article(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    id_category INT NOT NULL,
		CONSTRAINT fk_article_category FOREIGN KEY (id_category) 
        REFERENCES category(id) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS seller(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS receipt(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    created_at DATETIME NOT NULL,
    id_seller INT,
		CONSTRAINT fk_receipt_seller FOREIGN KEY (id_seller)
        REFERENCES seller(id) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS article_receipt(
	id_article INT,
    id_receipt INT,
    quantity INT,
    PRIMARY KEY (id_article, id_receipt),
		CONSTRAINT fk_ar_article FOREIGN KEY (id_article)
        REFERENCES article(id),
        CONSTRAINT fk_ar_receipt FOREIGN KEY (id_receipt)
        REFERENCES receipt(id)
)ENGINE=InnoDB;
/*
-- Constrainte de validation
-- Vérifier que le prix est positif
ALTER TABLE article
ADD CONSTRAINT check_positif_price
CHECK(price > 0),
-- title -> article : nom plus grand que 2 caractères,
ADD CONSTRAINT check_name_length
CHECK(length(title) > 2);

-- name -> categoy : nom plus que 1 caractère et plus petit que 50,
ALTER TABLE category
ADD CONSTRAINT check_name_length
CHECK(char_length(`name`) BETWEEN 2 AND 49);

-- created_at -> receipt : date supérieure ou égale à la date du moment.
DELIMITER $$
CREATE TRIGGER trigger_created_at_valid
BEFORE INSERT ON receipt
FOR EACH ROW
BEGIN
	IF NEW.created_at >= now() THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La date est inférieur à la date du jour';
        END IF;
	END; $$

ALTER TABLE article_receipt
ADD CONSTRAINT check_positive_quantity
CHECK(quantity > 0 AND quantity < 100000);

-- firstname -> seller : nom plus grand que 2 et plus petit que 25,
ALTER TABLE seller
ADD CONSTRAINT check_firstname_length
CHECK(char_length(firstname) BETWEEN 2 AND 25),
 -- lastname -> seller : ne contient pas de chiffre.
ADD CONSTRAINT check_lastanme_nonumber
CHECK(lastname NOT REGEXP '[0-9]');
*/
INSERT INTO category (`name`) VALUES
('Électronique'),
('Vêtements'),
('Alimentation'),
('Meubles'),
('Jouets'),
('Produits de beauté'),
('Livres'),
('Sport'),
('Bricolage'),
('Jardinage');

INSERT INTO article (title, price, id_category) VALUES
-- Électronique (1)
('Smartphone Galaxy A15', 249.99, 1),
('Ordinateur portable Lenovo IdeaPad', 649.90, 1),
('Casque Bluetooth Sony WH-CH520', 79.99, 1),
('Télévision Samsung 55"', 699.00, 1),
('Montre connectée Fitbit Versa 4', 199.50, 1),

-- Vêtements (2)
('T-shirt coton homme', 14.99, 2),
('Jean slim femme', 39.90, 2),
('Veste en cuir', 119.00, 2),
('Chaussures de sport Nike', 89.90, 2),
('Sweat à capuche unisexe', 34.50, 2),

-- Alimentation (3)
('Pâtes spaghetti 1kg', 2.49, 3),
('Huile d’olive extra vierge 1L', 6.90, 3),
('Café moulu arabica 250g', 4.99, 3),
('Chocolat noir 70%', 2.75, 3),
('Biscuits sablés', 3.10, 3),

-- Meubles (4)
('Table en bois massif', 249.00, 4),
('Chaise design blanche', 59.90, 4),
('Canapé 3 places gris', 699.00, 4),
('Bureau d’angle moderne', 189.99, 4),
('Lit double 160x200', 399.00, 4),

-- Jouets (5)
('Peluche ours brun', 19.99, 5),
('Jeu de société Monopoly', 34.90, 5),
('Lego Star Wars X-Wing', 79.99, 5),
('Puzzle 1000 pièces', 14.50, 5),
('Voiture téléguidée', 29.90, 5),

-- Produits de beauté (6)
('Shampoing hydratant 250ml', 7.90, 6),
('Crème visage jour', 14.99, 6),
('Parfum femme 50ml', 49.90, 6),
('Gel douche à la lavande', 5.99, 6),
('Rouge à lèvres mat', 12.50, 6),

-- Livres (7)
('Le Petit Prince', 8.90, 7),
('1984 - George Orwell', 9.50, 7),
('L’Étranger - Camus', 7.99, 7),
('Harry Potter à l’école des sorciers', 12.99, 7),
('Les Misérables - Victor Hugo', 14.50, 7),

-- Sport (8)
('Ballon de football Adidas', 29.90, 8),
('Raquette de tennis Wilson', 89.00, 8),
('Tapis de yoga antidérapant', 25.00, 8),
('Haltères 2x5kg', 34.90, 8),
('Vélo de route Btwin', 499.00, 8);

-- Bricolage (9)
INSERT INTO article (title, price, id_category) VALUES
('Perceuse sans fil Bosch', 129.00, 9),
('Tournevis multifonctions', 14.99, 9),
('Marteau de charpentier', 9.99, 9),
('Boîte à outils 50 pièces', 59.00, 9),
('Peinture murale blanche 5L', 34.90, 9),

-- Jardinage (10)
('Tondeuse électrique', 189.00, 10),
('Gants de jardinage', 6.50, 10),
('Sécateur de précision', 14.90, 10),
('Arrosoir 10L', 12.00, 10),
('Graines de tomates bio', 3.99, 10);

INSERT INTO seller (firstname, lastname) VALUES
('Marie', 'Durand'),
('Thomas', 'Leroy'),
('Sophie', 'Martin'),
('Antoine', 'Dupuis'),
('Claire', 'Bernard');

INSERT INTO receipt (created_at, id_seller) VALUES
('2025-10-01 09:15:00', 1),
('2025-10-01 14:32:00', 2),
('2025-10-02 10:45:00', 3),
('2025-10-02 16:20:00', 4),
('2025-10-03 11:10:00', 5),
('2025-10-04 13:55:00', 1),
('2025-10-05 15:25:00', 2),
('2025-10-06 09:40:00', 3),
('2025-10-06 17:05:00', 4),
('2025-10-07 12:30:00', 5);

-- Ticket 1
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(1, 1, 1), (12, 1, 2), (25, 1, 1);

-- Ticket 2
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(7, 2, 1), (19, 2, 1), (43, 2, 3);

-- Ticket 3
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(3, 3, 1), (8, 3, 2), (33, 3, 1);

-- Ticket 4
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(15, 4, 1), (22, 4, 1), (41, 4, 1);

-- Ticket 5
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(5, 5, 1), (26, 5, 2), (48, 5, 1);

-- Ticket 6
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(9, 6, 1), (13, 6, 1), (30, 6, 1);

-- Ticket 7
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(2, 7, 1), (20, 7, 2), (36, 7, 1);

-- Ticket 8
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(10, 8, 1), (29, 8, 3), (47, 8, 1);

-- Ticket 9
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(4, 9, 1), (11, 9, 1), (35, 9, 2);

-- Ticket 10
INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUES
(6, 10, 1), (24, 10, 1), (44, 10, 1);