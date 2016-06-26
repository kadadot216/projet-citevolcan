<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<title>PHP TP2</title>

</head>
<body>

<h1>Températures les plus élevées du "printemps"</h1>

<?php

/*Déclaration des variables...*/
$temperatures = array(
20.10,22.50,23.30,15.00,16.50,27.80,28.00,23.50,24.00,25.00,23.50,15.00,18.90,27.00,26.50,
20.00,23.00,23.50,27.00,27.20,20.00,23.50,24.00,25.00,23.50,26.50,28.00,30.00,32.00,29.50
);

$sommetemps=0;
foreach ($temperatures as $value) {
	$sommetemps += $value;
}

/*Trie l'array du plus grand au plus petit*/
rsort($temperatures);

/*On prend les 5 premières valeurs : */
$high_temps = array_slice($temperatures, 0,5);
/*On prend les 5 dernières valeurs : */
$low_temps = array_slice($temperatures, -5,5);

echo "La température moyenne est de " . round($sommetemps/30,2) . " °C <br/><br/>";
disp($high_temps,"5 plus hautes températures : ");
disp($low_temps,"5 plus basses températures : ");

function disp($tableau,$text)
{
echo $text . "<br/> ";
foreach ($tableau as $value) {
	echo $value . " °C <br/>";
}
echo "<br/>";
}

/*print_r($high_temps);
echo "<br>";
print_r($low_temps);*/

?>
</body>
</html>