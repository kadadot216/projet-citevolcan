-- CREATION DDBS

CREATE DATABASE IF NOT EXISTS citevolcan_db;

CREATE TABLE IF NOT EXISTS citevolcan_db.famille
(
	f_id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	famille_nom VARCHAR(255) NOT NULL
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS citevolcan_db.type
(
	t_id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	type_nom VARCHAR(255) NOT NULL
) ENGINE = INNODB;


CREATE TABLE IF NOT EXISTS citevolcan_db.mineraux
(
	E_id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	nom VARCHAR(255) NOT NULL,
	famille_id SMALLINT, 
	type_id SMALLINT, 
	image_path VARCHAR(255) NOT NULL,
	CONSTRAINT fk_fam
		FOREIGN KEY (famille_id)
		REFERENCES famille(f_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_type
			FOREIGN KEY (type_id)
			REFERENCES type(t_id)
			ON DELETE CASCADE
			ON UPDATE CASCADE
) ENGINE = INNODB;

-- ALTER TABLE citevolcan_db.mineraux ADD PRIMARY_KEY (M_id);

-- INSERER VARIABLES DANS DB 

INSERT INTO citevolcan_db.famille
	(famille_nom)
	VALUES
	('Pyroxènes'),
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
	('Pyroxène',1,1,"./img_mineraux/volcaniques/lpna_pyroxene.jpg"),
	('Hornblende',2,1,"./img_mineraux/volcaniques/lpna_amphibiole.jpg"),
	('Biotite',3,1,"./img_mineraux/volcaniques/lpna_micas.jpg"),
	('Quartz',4,1,"./img_mineraux/volcaniques/lpna_quartz.jpg"),
	('Orthose/Sanidine',5,1,"./img_mineraux/volcaniques/lpna_orthose_sanidine.jpg"),
	('Plagioclase',5,1,"./img_mineraux/volcaniques/lpna_plagioclase.jpg"),
	('Pyroxène',1,2,"./img_mineraux/plutoniques/lpna_pyroxene.jpg"),
	('Hornblende',2,2,"./img_mineraux/plutoniques/lpna_amphibiole.jpg"),
	('Micas',3,2,"./img_mineraux/plutoniques/lpna_micas.jpg"),
	('Quartz',4,2,"./img_mineraux/plutoniques/lpna_quartz.jpg"),
	('Orthose',5,2,"./img_mineraux/plutoniques/lpna_orthose.jpg"),
	('Plagioclases',5,2,"./img_mineraux/plutoniques/lpna_plagioclases.jpg"),
	('Grenat',3,NULL,"./img_mineraux/metamorphiques/lpna_grenat.jpg"),
	('Jadéite',3,NULL,"./img_mineraux/metamorphiques/lpna_jadeite.jpg"),
	('Plagioclase',3,NULL,"./img_mineraux/metamorphiques/lpna_plagioclase.jpg"),
	('Pyroxène relique',3,NULL,"./img_mineraux/metamorphiques/lpna_pyroxene_rel.jpg"),
	('Hornblende',3,NULL,"./img_mineraux/metamorphiques/lpna_hornblende.jpg"),
	('Glaucophane',3,NULL,"./img_mineraux/metamorphiques/lpna_glaucophane.jpg"),
	('Hornblende',2,4,"./img_mineraux/granites/lpna_hornblende.jpg"),
	('Muscovite',3,4,"./img_mineraux/granites/lpna_muscovite.jpg"),
	('Biotite',3,4,"./img_mineraux/granites/lpna_biotite.jpg"),
	('Quartz',4,4,"./img_mineraux/granites/lpna_quartz.jpg"),
	('Orthose',5,4,"./img_mineraux/granites/lpna_orthose.jpg"),
	('Plagioclase',5,4,"./img_mineraux/granites/lpna_plagioclase.jpg")
	;




-- ######################################################
-- SUPPRESSION DDBS

-- ALTER TABLE famille DROP INDEX id;
ALTER TABLE citevolcan_db.mineraux DROP FOREIGN KEY fk_fam;
ALTER TABLE citevolcan_db.mineraux DROP FOREIGN KEY fk_type;
DROP table citevolcan_db.famille;
DROP table citevolcan_db.mineraux;
DROP table citevolcan_db.type;
-- DROP table famille;

TRUNCATE table citevolcan_db.mineraux;
TRUNCATE table citevolcan_db.famille;

('',1,$1),