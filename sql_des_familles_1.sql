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
	('Hornblende',1,"./img_mineraux/granites/lpna_hornblende.jpg"),
	('Plagioclase',1,"./img_mineraux/granites/lpna_plagioclase.jpg"),
	('Biotite',1,"./img_mineraux/granites/lpna_biotite.jpg"),
	('Quartz',1,"./img_mineraux/granites/lpna_quartz.jpg"),
	('Orthose',1,"./img_mineraux/granites/lpna_orthose.jpg"),
	('Muscovite',1,"./img_mineraux/granites/lpna_muscovite.jpg"),
	('Amphibiole',2,"./img_mineraux/magmatiques/lpna_amphibiole.jpg"),
	('Plagioclase',2,"./img_mineraux/magmatiques/lpna_plagioclase.jpg"),
	('Pyroxène',2,"./img_mineraux/magmatiques/lpna_pyroxene.jpg"),
	('Quartz',2,"./img_mineraux/magmatiques/lpna_quartz.jpg"),
	('Micas',2,"./img_mineraux/magmatiques/lpna_micas.jpg"),
	('Orthose/Sanidine',3,"./img_mineraux/magmatiques/lpna_orthose_sanidine.jpg"),
	('Hornblende',3,"./img_mineraux/metamorphiques/lpna_hornblende.jpg"),
	('Glaucophane',3,"./img_mineraux/metamorphiques/lpna_glaucophane.jpg"),
	('Grenat',3,"./img_mineraux/metamorphiques/lpna_grenat.jpg"),
	('Plagioclase',3,"./img_mineraux/metamorphiques/lpna_plagioclase.jpg"),
	('Jadéite',3,"./img_mineraux/metamorphiques/lpna_jadeite.jpg"),
	('Pyroxène relique',3,"./img_mineraux/metamorphiques/lpna_pyroxene_rel.jpg"),
	('Plagioclases',4,"./img_mineraux/plutoniques/lpna_plagioclases.jpg"),
	('Amphibiole',4,"./img_mineraux/plutoniques/lpna_amphibiole.jpg"),
	('Pyroxène',4,"./img_mineraux/plutoniques/lpna_pyroxene.jpg"),
	('Quartz',4,"./img_mineraux/plutoniques/lpna_quartz.jpg"),
	('Orthose',4,"./img_mineraux/plutoniques/lpna_orthose.jpg"),
	('Micas',4,"./img_mineraux/plutoniques/lpna_micas.jpg")
	;




-- ######################################################
-- SUPPRESSION DDBS

-- ALTER TABLE famille DROP INDEX id;
ALTER TABLE citevolcan_db.mineraux DROP FOREIGN KEY fk_fam;
DROP table citevolcan_db.famille;
-- DROP table famille;
DROP table citevolcan_db.mineraux;
TRUNCATE table citevolcan_db.mineraux;

('',1,$1),