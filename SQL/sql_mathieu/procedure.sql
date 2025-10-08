Delimiter $$
CREATE PROCEDURE addCategory(
IN name_category VARCHAR(50)
)
BEGIN
-- Vérifier si la catégorie existe
if (SELECT id FROM category WHERE name = name_category) > 0 THEN
	ROLLBACK;
	SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Attention la catégorie existe déjà' ;
ELSE
	INSERT INTO category(name) VALUE (name_category);
    COMMIT;
END IF;
END
$$

CALL addCategory('Alimentation');