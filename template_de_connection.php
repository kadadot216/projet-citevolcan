<?php
function connectDB($localhost,$login,$passwd,$dbb )
{
// Créée la connection
	$conn = new mysqli($localhost, $login, $passwd, $dbb);
// Vérifie la connection
	echo ($conn->connect_error) ? "Erreur de connection: "
	. $conn->connect_error . "\n" : "Connection réussie!\n";
	return $conn;
}
function insertDB($link,$ethx,$val,$date)
{
//Lance requête SQL d'insertion dans BDD
	$sqli = "INSERT INTO ethx (etat, date_du_jour) VALUES ('".$ethx."+".$val."','".$date."')";
//Vérifie la requête SQL
	if ($link->query($sqli) === TRUE) {
		echo "New record created successfully\n";
	} else {
		echo "Error: " . $sqli . "<br>" . $link->error;
	}
}

function affalinDB($link)
{
//Lance requête SQL de séléction dans BDD
	$sqlr = "SELECT id,etat,date_du_jour FROM ethx";
	$result = $link->query($sqlr);
//Si au moins une ligne de résultats..
	if ($result->num_rows > 0) {
//Création d'un tableau qui va permettre d'afficher les résultats
		echo "<table><tr><th>ID</th><th>ETH + VALEUR</th><th>DATE</th></tr>";
		while($row = $result->fetch_assoc()) {
			echo "<tr><td>".$row["id"]."</td><td>".$row["etat"]."</td><td>".$row["date_du_jour"]."</td></tr>";
		}
	} else {
		echo "0 results";
	}
}
//Ferme la connection
function closeDB($link)
{
	$link->close();
}

$link = connectDB("localhost","root","111111","citevolcan_db");
insertDB($link,"test","test","test");
affalinDB($link);
closeDB($link);
?>