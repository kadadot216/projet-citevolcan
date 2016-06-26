-- CREATION DDBS

CREATE DATABASE IF NOT EXISTS citevolcan_db;

CREATE TABLE IF NOT EXISTS citevolcan_db.famille
(
	id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	famille_nom VARCHAR(255) NOT NULL
) ENGINE = INNODB;



CREATE TABLE IF NOT EXISTS citevolcan_db.mineraux
(
	id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	nom VARCHAR(255) NOT NULL,
	famille_id SMALLINT, 
	image_path VARCHAR(255) NOT NULL,
	CONSTRAINT fk_fam
		FOREIGN KEY (famille_id)
		REFERENCES famille(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE = INNODB;

-- ALTER TABLE citevolcan_db.mineraux ADD PRIMARY_KEY (M_id);

-- INSERER VARIABLES DANS DB 

INSERT INTO citevolcan_db.famille
	(famille_nom)
	VALUES
	('Granites'),
	('Magmatiques'),
	('Metamorphiques'),
	('Plutoniques') 
	;

INSERT INTO citevolcan_db.mineraux
	(nom,famille_id,image_path)
	VALUES
	('Biotite',1,"./img_mineraux/granites/lpna_biotite.jpg"),
	('Hornblende',1,"./img_mineraux/granites/lpna_hornblende.jpg"),
	('Muscovite',1,"./img_mineraux/granites/lpna_muscovite.jpg"),
	('Orthose',1,"./img_mineraux/granites/lpna_orthose.jpg"), 
	('Plagioclase',1,"./img_mineraux/granites/lpna_plagioclase.jpg"), 
	('Quartz',1,"./img_mineraux/granites/lpna_quartz.jpg"), 
	('Biotite',2,"./img_mineraux/magmatiques/lpna_biotite.jpg"),
	('Hornblende',2,"./img_mineraux/magmatiques/lpna_hornblende.jpg"),
	('Muscovite',2,"./img_mineraux/magmatiques/lpna_muscovite.jpg"),
	('Orthose',2,"./img_mineraux/magmatiques/lpna_orthose.jpg"), 
	('Plagioclase',2,"./img_mineraux/magmatiques/lpna_plagioclase.jpg"), 
	('Quartz',2,"./img_mineraux/magmatiques/lpna_quartz.jpg")
	;

-- ######################################################
-- SUPPRESSION DDBS

-- ALTER TABLE famille DROP INDEX id;
ALTER TABLE citevolcan_db.mineraux DROP FOREIGN KEY fk_fam;
DROP table citevolcan_db.famille;
-- DROP table famille;
DROP table citevolcan_db.mineraux;