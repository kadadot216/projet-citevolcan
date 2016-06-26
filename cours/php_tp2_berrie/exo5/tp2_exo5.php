<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<title>PHP TP2</title>

</head>
<body>

<h1>Les Grandes Villes</h1>

<?php

 //Create array.
 $cities=array(
"Japon" => "Tokyo",
"Mexique" => "Mexico",
"Etats-Unis" => "New York",
"Inde" => "Bombay",
"Corée du Sud" => "Séoul",
"Chine" => "Shanghai",
"Nigeria" => "Lagos",
"Argentine" => "Buenos Aires",
"Egypte" => "Caire",
"Grande-Bretagne" => "Londre"
 );

/*Si le bouton submit retourne une valeur alors..*/
if (isset($_POST['submit']))
{ 
	$ville = $_POST['ville'];
	/*On trouve la clé correspondante à la valeur reçue par rapport au tableau $cities*/
	$pays = array_search($ville,$cities);
	echo "<p>" . $ville . " est dans ce pays : ". $pays ."</p>";
}
/*Sinon... on fait apparaître le formulaire...*/
else
{  ?>

<p>S'îl vous plaît, choissez une ville : </p>

<FORM METHOD="POST" ACTION="<?php echo $_SERVER['PHP_SELF']; ?>">

<SELECT name="ville" size="1">
<OPTION VALUE="Tokyo" >Tokyo
<OPTION VALUE="Mexico" >Mexico
<OPTION VALUE="New York" >New York
<OPTION VALUE="Bombay" >Bombay
<OPTION VALUE="Séoul" >Séoul
<OPTION VALUE="Shangai" >Shangai
<OPTION VALUE="Lagos" >Lagos
<OPTION VALUE="Buenos Aires" >Buenos Aires
<OPTION VALUE="Caire" >Caire
<OPTION VALUE="Londre">Londre
</SELECT>
 
<INPUT name="submit" type="submit" value="Valider" />

</FORM>

<?php } ?>

</body>
</html>