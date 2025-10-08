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