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
	text-align: center;
    border: 1px solid black;
}
</style>
</head>
<body>


<?php
$multiVilles=
array(
	array('Ville', 'Pays', 'Continent'),
	array('Tokyo', 'Japon', 'Asie'),
	array('Mexico','Mexique', 'Amérique du Nord'),
	array('La ville de New York', 'USA', 'Amérique du Nord'),
	array('Bombay', 'Inde', 'Asie'),
	array('Séoul', 'Corée', 'Asie'),
	array('Shanghai', 'Chine', 'Asie'),
	array('Lagos', 'Nigeria', 'Afrique'),
	array('Buenos Aires', 'Argentine', 'Amérique du sud'),
	array('Caire', 'Egypte', 'Afrique'),
	array('Londre', 'Royaume-Uni','Europe')
);

	/*Variable qui va permettre de prononcer le style de Ville, Pays, Continent...*/
	$titre=TRUE;

?>

<table>
		<?php 
		/*Pour chaque sous-tableau dans le tableau*/
		foreach ($multiVilles as $sousArray) {
			/*On ouvre la ligne*/
			echo "<tr>";
			/*Pour chaque valeur dans chaque sous-tableau*/
			foreach ($sousArray as $value) {
			/*Si $titre est vrai alors on met les tags de titre poru les 3 colonnes de la ligne*/
			/*Sinon, on met les tags de colonne*/
			echo ($titre === TRUE) ? "<th>" . $value . "</th>" : "<td>" . $value . "</td>" ;
			}
			/*On ferme la ligne...*/
			echo "</tr>";
			/*Met $titre en false pour ne plus avoir recours au titres*/
			if ($titre === TRUE) {$titre = FALSE;}
		}
		 ?>
</table>

</body>
</html>