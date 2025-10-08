-- Création d'une table utilisateur
CREATE TABLE IF NOT EXISTS utilisateur(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email VARCHAR(50) NOT NULL,
    `password`VARCHAR(100) NOT NULL
)ENGINE= InnoDB;

DELIMITER $$
-- 5 Créer une procédure qui va vérifier si le compte n'existe pas déja (email),
CREATE PROCEDURE verif_user(
IN new_email VARCHAR(50)
)
BEGIN
	-- tester si le compte existe
    IF (SELECT u.id FROM utilisateur WHERE u.email = new_email) > 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '10000'  SET MESSAGE_TEXT = 'Attention le compte existe déjà';
    END IF;
    IF (SELECT u.id FROM utilisateur AS u WHERE u.email = new_email) IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Le compte n\'existe pas';
    END IF;
END;
$$

-- 6 Créer une procédure qui va créer le compte et hasher son mot de passe en MD5,
DELIMITER $$
CREATE PROCEDURE add_user(
IN new_email VARCHAR(50),
IN new_password VARCHAR(100)
)
BEGIN
	IF (SELECT u.id FROM utilisateur u WHERE u.email = new_email) > 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '10000'  SET MESSAGE_TEXT = 'Attention le compte existe déjà';
    END IF;
    -- Ajouter le compte et son mdp
    INSERT INTO utilisateur(email,`password`) VALUE(new_email, md5(new_password));
    COMMIT;
END
$$

-- 7 Créer une procédure qui va vérifier si le compte est valide et le mot de passe est correct (vérifier le hash MD5),
DELIMITER $$
CREATE PROCEDURE connexion(
IN new_email VARCHAR(50),
IN new_password VARCHAR(100)
)
BEGIN
	-- Tester si le mail ou password est incorrect
    IF(SELECT u.id FROM utilisateur u WHERE u.email= new_email AND `password` = md5(new_password)) IS NULL THEN
		ROLLBACK;
		SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'LEs infos de connexion sont incorrectes';
	END IF;
    SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Les infos sont correctes';

END
$$
-- 8 Créer une procédure qui va permettre de mettre à jour le mot de passe en vérifiant l'ancien mot de passe (Hash md5) et le remplacer par le nouveau mot de passe(hasher également en MD5).
DELIMITER $$
CREATE PROCEDURE update_password(
IN new_email VARCHAR(50),
IN new_old_password VARCHAR(100),
IN new_password VARCHAR(100)
)
BEGIN
	-- Tester si l'ancien mdp et le compte n'existent pas
    IF (SELECT u.id FROM utilisateur u WHERE u.email = new_email AND u.`password`= md5(new_old_password)) IS NULL THEN
		ROLLBACK;
		SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'LEs infos de connexion sont incorrectes';
	END IF;
    -- test si l'ancien mdp est identique au nouveau
    IF (new_password = new_old_password) THEN
		ROLLBACK;
        SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Les 2 mdp son idententiques';
	END IF;
    -- Update du password
    UPDATE utilisateur SET `password` = md5(new_password) WHERE email = new_email;
END
$$