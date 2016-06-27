-- CREATION DDBS

CREATE DATABASE IF NOT EXISTS citevolcan_db;

CREATE TABLE IF NOT EXISTS citevolcan_db.famille
(
	id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	famille_nom VARCHAR(255) NOT NULL
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS citevolcan_db.type
(
	id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	type_nom VARCHAR(255) NOT NULL
) ENGINE = INNODB;


CREATE TABLE IF NOT EXISTS citevolcan_db.mineraux
(
	id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	nom VARCHAR(255) NOT NULL,
	famille_id SMALLINT, 
	type_id SMALLINT, 
	image_path VARCHAR(255) NOT NULL,
	CONSTRAINT fk_fam
		FOREIGN KEY (famille_id)
		REFERENCES famille(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_type
			FOREIGN KEY (type_id)
			REFERENCES type(id)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;

-- ALTER TABLE citevolcan_db.mineraux ADD PRIMARY_KEY (M_id);

-- INSERER VARIABLES DANS DB 

INSERT INTO citevolcan_db.famille
	(famille_nom)
	VALUES
	('Pyroxenes'),
	('Amphibioles'),
	('Micas'),
	('Quartz'),
	('Feldspath')
	;

INSERT INTO citevolcan_db.type
	(type_nom)
	VALUES
	('Roches magmatiques volcaniques'),
	('Roches magmatiques plutoniques'),
	('Roches métamorphiques'),
	('Roches granitiques')
	;

INSERT INTO citevolcan_db.mineraux
	(nom,famille_id,type_id,image_path)
	VALUES
	('Hornblende',1,1,"./img_mineraux/granites/lpna_hornblende.jpg"),
	('Plagioclase',1,1,"./img_mineraux/granites/lpna_plagioclase.jpg"),
	('Biotite',1,1,"./img_mineraux/granites/lpna_biotite.jpg"),
	('Quartz',1,1,"./img_mineraux/granites/lpna_quartz.jpg"),
	('Orthose',1,1,"./img_mineraux/granites/lpna_orthose.jpg"),
	('Muscovite',1,1,"./img_mineraux/granites/lpna_muscovite.jpg"),
	('Amphibiole',2,1,"./img_mineraux/magmatiques/lpna_amphibiole.jpg"),
	('Plagioclase',2,1,"./img_mineraux/magmatiques/lpna_plagioclase.jpg"),
	('Pyroxène',2,1,"./img_mineraux/magmatiques/lpna_pyroxene.jpg"),
	('Quartz',2,1,"./img_mineraux/magmatiques/lpna_quartz.jpg"),
	('Micas',2,1,"./img_mineraux/magmatiques/lpna_micas.jpg"),
	('Orthose/Sanidine',3,1,"./img_mineraux/magmatiques/lpna_orthose_sanidine.jpg"),
	('Hornblende',3,1,"./img_mineraux/metamorphiques/lpna_hornblende.jpg"),
	('Glaucophane',3,1,"./img_mineraux/metamorphiques/lpna_glaucophane.jpg"),
	('Grenat',3,1,"./img_mineraux/metamorphiques/lpna_grenat.jpg"),
	('Plagioclase',3,1,"./img_mineraux/metamorphiques/lpna_plagioclase.jpg"),
	('Jadéite',3,1,"./img_mineraux/metamorphiques/lpna_jadeite.jpg"),
	('Pyroxène relique',3,1,"./img_mineraux/metamorphiques/lpna_pyroxene_rel.jpg"),
	('Plagioclases',4,1,"./img_mineraux/plutoniques/lpna_plagioclases.jpg"),
	('Amphibiole',4,1,"./img_mineraux/plutoniques/lpna_amphibiole.jpg"),
	('Pyroxène',4,1,"./img_mineraux/plutoniques/lpna_pyroxene.jpg"),
	('Quartz',4,1,"./img_mineraux/plutoniques/lpna_quartz.jpg"),
	('Orthose',4,1,"./img_mineraux/plutoniques/lpna_orthose.jpg"),
	('Micas',4,1,"./img_mineraux/plutoniques/lpna_micas.jpg")
	;




-- ######################################################
-- SUPPRESSION DDBS

-- ALTER TABLE famille DROP INDEX id;
ALTER TABLE citevolcan_db.mineraux DROP FOREIGN KEY fk_fam;
DROP table citevolcan_db.famille;
-- DROP table famille;
DROP table citevolcan_db.mineraux;
ALTER TABLE citevolcan_db.mineraux DROP FOREIGN KEY fk_fam;
TRUNCATE table citevolcan_db.mineraux;
TRUNCATE table citevolcan_db.famille;

('',1,$1),