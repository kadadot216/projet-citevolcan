<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<title>PHP TP2</title>
</head>
<body>

	<?php 
 //Create array.
 $cities=array(
 "Tokyo",
 "Mexico",
 "New York",
 "Bombay",
 "Séoul",
 "Shanghai",
 "Lagos",
 "Buenos Aires",
 "Caire",
 "Londre"
 );

sort($cities, SORT_NATURAL);

echo "Avant : ";
affichCities();

array_push($cities,"Paris","Calcutta");

echo "<br/> Après : ";
affichCities();


function affichCities() {
	global $cities;

	echo "<ul>";

	 foreach ($cities as &$value){
		echo "<li>" . $value . "</li>";
	}
}

echo "</ul>";


	 ?>
</body>
</html>




