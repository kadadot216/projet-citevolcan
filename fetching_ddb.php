<?php
function connectDB($localhost,$login,$passwd,$dbb ) {
	$conn = new mysqli($localhost, $login, $passwd, $dbb);
	echo ($conn->connect_error) ? "Erreur de connection: ". $conn->connect_error . "\n" : "Connection réussie!\n";
	return $conn;
}

function fetchDB($link) {
	$sqlr = "SELECT mineraux.id,mineraux.nom,famille.famille_nom,mineraux.image_path 
		FROM mineraux LEFT JOIN famille 
		ON famille.id=mineraux.famille_id ";
	// 	$sqlr = "SELECT c.*,p.* FROM mineraux c, famille p WHERE c.famille_id=p.id";
	$result = $link->query($sqlr);
 
	if ($result->num_rows > 0) {
 
		echo "<table><tr>
		<th>ID</th>
		<th>NOM</th>
		<th>FAMILLE</th>
		<th>PATH</th>
		</tr>";
		while($row = $result->fetch_assoc()) {
			echo "<tr>
			<td>".$row["id"]."</td>
			<td>".$row["nom"]."</td>
			<td>".$row["famille_nom"]."</td>
			<td>".$row["image_path"]."</td>
			</tr>";
		}
	} else {
		echo "0 results";
	}
}
 
function closeDB($link) {
	$link->close();
}

$link = connectDB("localhost","root","111111","citevolcan_db");
fetchDB($link);
closeDB($link);

?>