-- CREATION DDBS

CREATE DATABASE IF NOT EXISTS citevolcan_db;

CREATE TABLE IF NOT EXISTS citevolcan_db.famille
(
	id SMALLINT UNIQUE NOT NULL AUTO_INCREMENT,
	nom VARCHAR(255) NOT NULL
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

-- SUPPRESSION DDBS

-- ALTER TABLE famille DROP INDEX id;
ALTER TABLE citevolcan_db.mineraux DROP FOREIGN KEY fk_fam;
DROP table citevolcan_db.famille;
-- DROP table famille;
DROP table citevolcan_db.mineraux;


