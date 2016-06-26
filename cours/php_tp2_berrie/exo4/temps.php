<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Temps</title>
</head>
<body>
<?php 
 
$inputl = $_POST['inputLocal'];
$temps = $_POST['temps'];

echo "Dans la ville de " . $inputl[0] . " au mois de " . $inputl[1] . " en " . $inputl[2] . ", vous avez observé les temps suivants :";
echo "<ul>";

foreach ($temps as &$value) {
	echo "<li>" . $value ."</li>";

}

echo "</ul>";


	 ?>
</body>
</html>