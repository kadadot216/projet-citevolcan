<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Requête SQL</title>

	 <style>
table, th, td {
     border: 1px solid black;
}
</style>

</head>
<body>
	
<?php 



function connectDB($localhost,$login,$passwd,$dbb )
{

// $localhost = "localhost";
// $login = "root";
// $passwd = "111111";
// $dbb = "valsystem_db";	

// Create connection
$conn = new mysqli($localhost, $login, $passwd, $dbb);
// Check connection
echo ($conn->connect_error) ? "Erreur de connection: " . $conn->connect_error . "\n" :  "Connection réussie!\n";
return $conn;
}



function insertDB($link,$ethx,$val,$date)
{

// $conn = connectDB();
$sqli = "INSERT INTO ethx (etat, date_du_jour) VALUES ('".$ethx."+".$val."','".$date."')";


if ($link->query($sqli) === TRUE) {
    echo "New record created successfully\n";
} else {
    echo "Error: " . $sqli . "<br>" . $link->error;
}

}





function affalinDB($link) 

{
	// $link = connectDB();
	$sqlr = "SELECT id,etat,date_du_jour FROM ethx";
$result = $link->query($sqlr);

if ($result->num_rows > 0) {
    echo "<table><tr><th>ID</th><th>ETH + VALEUR</th><th>DATE</th></tr>";
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>".$row["id"]."</td><td>".$row["etat"]."</td><td>".$row["date_du_jour"]."</td></tr>";
    }
} else {
    echo "0 results";
}

}

function closeDB($link)
{
    $link->close();
}

$link = connectDB("localhost","root","","valsystem_db");
insertDB($link,"test","test","test");
affalinDB($link);
closeDB($link);

?>


</body>
</html>