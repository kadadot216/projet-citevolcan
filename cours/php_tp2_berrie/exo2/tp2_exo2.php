<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<title>PHP TP2</title>
	<style type="text/css">
	table {
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid black;
}
</style>
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



array_push($cities,"Paris","Calcutta");

echo "Affichage en mode \"table\" : ";
aff($cities,"table");

echo "<br/>Affichage en mode \"lilu\" : ";
aff($cities,"lilu");

echo "<br/>Affichage incorrect : ";
aff($cities,"kek");

function aff($tab,$typeaff) {

	if ($typeaff == "table") 
	{
		$count=1;
		echo "<table><tr>";
	
		 foreach ($tab as &$value){
		 	/*Donne du "volume" au tableau mais ne marche pas correctement*/ 
		 	if ($count == 4) {
		 		echo "</tr><tr>";
		 		$count=0;
		 	}
			echo "<td> " . $value . " </td>";
			$count++;
		}
		echo "</table>";
	}

	elseif ($typeaff == "lilu") 
	{
		echo "<ul>";

		 foreach ($tab as &$value){
			    echo "<li>" . $value . "</li>";
		}
		echo "</ul>";
	}

	else {echo "<br/>Erreur sur typeaff! ";}

}




	 ?>
</body>
</html>




