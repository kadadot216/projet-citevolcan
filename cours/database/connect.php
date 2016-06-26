<?php

mysql_connect("localhost", "root", "111111") or die("Impossible de se connecter : " . mysql_error());

echo 'Connexion réussie';

mysql_select_db('citevolcan_db') or die('Problème dans la cabine');

echo 'Base de données selectionnée';
?>