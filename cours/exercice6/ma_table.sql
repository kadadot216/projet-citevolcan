CREATE DATABASE valsystem_db CHARACTER SET 'utf8';

	CREATE TABLE ethx 
	(
		id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
		etat VARCHAR(20) NOT NULL,
		date_du_jour DATETIME NOT NULL,
		PRIMARY KEY (id)
	)
	 ENGINE=MyISAM;
	