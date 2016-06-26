<?php

$link = mysql_connect("localhost", "root", "111111")
    or die("Impossible de se connecter : " . mysql_error());
echo 'Connexion réussie';
mysql_close($link);

// N'oublie pas la connexion à ta base de données avant ça !
 
$req = mysql_query("select * FROM citevolcan.db WHERE id = '".$_SESSION["root"]."111111") or die(mysql_error());
 
$data = mysql_fetch_array($req);
 
$user_image = $data['lpna_biotite.jpg'];
 
$repertoire = "/var/www/projet-citevolcan/database/images_mineraux/granites/";
 
?>
 
<img src="<?php echo $repertoire.$user_image; ?>" alt="" />