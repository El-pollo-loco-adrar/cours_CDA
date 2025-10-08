delimiter $$
-- 1 Créer un article(title, price, id_category) en vérifiant : si il n'existe pas, si le prix est supérieur à 0,
CREATE PROCEDURE addProduit(
	IN titre VARCHAR(50), 
    IN prix FLOAT,
    IN idCat INT
)
BEGIN
	DECLARE idExiste INT;
    
    -- Vérification si le produit existe 
    SELECT id INTO idExiste
    FROM article
    WHERE title = titre
    LIMIT 1;
    
    -- Si produit existe, on ajoute l'erreur
    IF idExiste IS NOT NULL THEN
		ROLLBACK;
        SIGNAL SQLSTATE '10000' 
			SET MESSAGE_TEXT = 'Le produit existe déjà.';
        
	-- Si le prix est invalide
	ELSEIF prix <= 0 THEN
		ROLLBACK;
        SIGNAL SQLSTATE '10001'
			SET MESSAGE_TEXT = 'Le prix doit être supérieur à 0';
            
	-- Sinon on insère le produit
    ELSE 
		INSERT INTO article (title, price, id_category)
        VALUES (titre, prix, idCat);
        COMMIT;
	END IF;
END
$$

CALL addProduit('Veste en cuir', 50, 2);

delimiter $$
-- 2 Créer un receipt (created_at, id_seller) dont la date est égale ou inférieure à la date du jour,
CREATE PROCEDURE addReceipt(
	IN date_receipt DATETIME,
    IN idVendeur INT
)
BEGIN
	-- Vérifie la date valide
    IF date_receipt > now() THEN
    ROLLBACK;
    SIGNAL SQLSTATE '10000'
		SET MESSAGE_TEXT = "La date du ticket n'est pas valide.";
	ELSE
		INSERT INTO receipt( created_at, id_seller)
        VALUES (date_receipt, idVendeur);
        COMMIT;
	END IF;
END
$$;

CALL addReceipt('2024-10-01 10:00:00', 4);

DROP PROCEDURE IF EXISTS addReceipt;

-- 3 Créer un receipt(created_at, id_seller) avec la date, vendeur, 2 articles (id_article, id_receipt, quantity),
DELIMITER $$
CREATE PROCEDURE add_receipt_article (
IN new_date DATETIME,
IN new_id_seller INT,
IN new_article_id1 INT,
IN new_article_id2 INT,
IN new_qtx1 INT,
IN new_qtx2 INT
)
BEGIN
    -- Appel de la procédure pour créer le ticket
    CALL add_receipt(new_date, new_id_seller);
    -- récupérer dans une variable l'id du ticket
    SET @id_receipt = (SELECT r.id FROM receipt AS r ORDER BY r.id DESC LIMIT 1);
    -- test si le produit 1 existe
    IF (SELECT a.id FROM article AS a WHERE a.id = new_article_id1) IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Attention le produit 1 n\'existe pas';
    END IF;
    -- test si le produit 2 existe
    IF (SELECT a.id FROM article AS a WHERE a.id = new_article_id2) IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Attention le produit 2 n\'existe pas';
    END IF;
    -- test si la quantité 1 est positive
    IF (new_qtx1 <= 0) THEN
        ROLLBACK;
        SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Attention la quantité 1 est négative';
    END IF;
    -- test si la quantité 2 est positive
    IF (new_qtx2 <= 0) THEN
        ROLLBACK;
        SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Attention la quantité 2 est négative';
    END IF;
    -- ajout des 2 produits au ticket
    INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUE (new_article_id1, @id_receipt, new_qtx1);
    INSERT INTO article_receipt (id_article, id_receipt, quantity) VALUE (new_article_id2, @id_receipt, new_qtx2);
END
$$

-- 4 Créer un seller (firstname, lastname) dont le nom et le prénom n'existe pas déja.
DELIMITER $$
CREATE PROCEDURE add_seller(
IN new_firstname VARCHAR(50),
IN new_lastname VARCHAR(50)
)
BEGIN
    -- Tester si le vendeur existe
    IF (SELECT s.id FROM seller AS s WHERE s.firstname = new_firstname AND s.lastname = new_lastname) > 0 THEN
            ROLLBACK;
            SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Attention le vendeur existe déja';
    END IF;
    -- ajout en BDD
    INSERT INTO seller(firstname,lastname) VALUE (new_firstname, new_lastname);
    COMMIT;
END
$$
