CREATE DATABASE IF NOT EXISTS clean_connect CHAR SET utf8mb4;
USE clean_connect;

CREATE TABLE IF NOT EXISTS roles(
	id_role INT PRIMARY KEY AUTO_INCREMENT,
    name_role VARCHAR(50) UNIQUE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS users(
	id_user INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_user VARCHAR(255) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    firstname VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(5) NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    id_role INT,
	CONSTRAINT fk_id_role 
		FOREIGN KEY (id_role) REFERENCES roles(id_role) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS message(
	id_message INT PRIMARY KEY AUTO_INCREMENT,
    content TEXT NOT NULL,
    date_message DATETIME NOT NULL,
    id_recipient INT,
    id_author INT,
    CONSTRAINT fk_message_recipient
		FOREIGN KEY (id_recipient) REFERENCES users(id_user) ON DELETE CASCADE,
	CONSTRAINT fk_message_author
		FOREIGN KEY (id_author) REFERENCES users(id_user) ON DELETE CASCADE
)ENGINE=InnoDB;


-- s sender r receiver m mailbox
SELECT r.email receveir, u.email sender, m.message, m.subject, m.date_message
FROM mailbox m
INNER JOIN users s ON s.id_user = m.id_sender 
INNER JOIN users r ON r.id_user = m.id_receiver;