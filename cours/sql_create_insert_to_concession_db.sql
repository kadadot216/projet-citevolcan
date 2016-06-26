CREATE TABLE client
(
	numero SMALLINT UNIQUE NOT NULL,
	nom VARCHAR(25),
	adresse VARCHAR(50),
	telephone TINYTEXT
) ENGINE=INNODB;

CREATE TABLE produit
(
	reference SMALLINT UNIQUE NOT NULL,
	marque VARCHAR(50),
	prix SMALLINT
) ENGINE=INNODB;

CREATE TABLE vente
(
	numero SMALLINT,
	ref_produit SMALLINT,
	no_client SMALLINT,
	date DATE,
	CONSTRAINT fk_ref
		FOREIGN KEY (ref_produit)
		REFERENCES produit(reference)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_client
		FOREIGN KEY (no_client)
		REFERENCES client(numero)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE=INNODB;



INSERT INTO client
	(numero,nom,adresse,telephone) 
VALUES 
	(101,"Durand","Nice","043939593959"),
	(106,"Fabre","Paris",NULL),
	(110,"Prosper","Paris",NULL),
	(125,"Antonin","Marseille","031929255615");


INSERT INTO produit
	(reference,marque,prix) 
VALUES 
	(153,"BMW",8000),
	(589,"Peugeot",7450),
	(158,"Toyota",6725),
	(600,"Citroen",7000);


INSERT INTO vente
	(numero,ref_produit,no_client,date) 
VALUES 
	(102,153,101,12/10/2004),
	(809,589,106,20/01/2005),
	(11005,158,106,15/03/2005),
	(12005,600,125,30/03/2005);

#http://forum.webrankinfo.com/difference-entre-primary-key-cle-index-unique-cle-index-t109160.html
#http://www.w3schools.com/sql/sql_create_index.asp