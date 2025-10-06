/*
-- Création de compte sql
CREATE USER 'wilb'@'%' IDENTIFIED BY 'azerty';

-- Donner les droits
GRANT ALL PRIVILEGES ON shop . * TO 'wilb'@'%';

-- Refresh
FLUSH PRIVILEGES;

-- Consulter les utilisateurs
SELECT * FROM mysql.user;

-- Donne les droits de la base shop . table à utilisateur
GRANT INSERT ON shop . seller TO 'wilb'@'%';
GRANT INSERT ON shop . category TO 'wilb'@'%';
GRANT INSERT ON shop . article TO 'wilb'@'%';

-- GRANT INSERT, UPDATE, DELETE

drop USER wilb;
*/
-- création du compte gestionnaire
CREATE USER 'gestionnaire'@'%'  IDENTIFIED BY 'exemple@1234';

-- affectation des droits
GRANT INSERT ON shop . seller TO 'gestionnaire'@'%';
GRANT INSERT ON shop . category TO  'gestionnaire'@'%';
GRANT INSERT ON shop . article TO  'gestionnaire'@'%';

GRANT SELECT, DELETE, UPDATE  ON shop . * TO 'gestionnaire'@'%';

CREATE USER 'vendeur'@'%' IDENTIFIED BY 'azerty';
GRANT SELECT ON shop . * TO 'vendeur'@'%';
GRANT INSERT ON shop . receipt TO 'vendeur'@'%';
GRANT INSERT ON shop . article_receipt TO 'vendeur'@'%';

CREATE USER 'inventaire'@'%' IDENTIFIED BY 'azerty';
GRANT SELECT ON shop . * to 'inventaire'@'%';

-- application des droits
FLUSH PRIVILEGES;