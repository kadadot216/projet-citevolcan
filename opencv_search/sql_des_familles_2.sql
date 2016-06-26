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