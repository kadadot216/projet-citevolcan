<?php

function connectDB($localhost,$login,$passwd,$dbb ) {
	$conn = new mysqli($localhost, $login, $passwd, $dbb);
	echo ($conn->connect_error) ? "Erreur de connection: ". $conn->connect_error . "\n" : "";
	return $conn;
}

function fetchDB($link) {
	$sqlr = "SELECT mineraux.id,mineraux.nom,famille.famille_nom,type.type_nom,mineraux.image_path 
		FROM mineraux 
		LEFT JOIN famille 
		ON famille.id=mineraux.famille_id
		LEFT JOIN type
		ON type.id=mineraux.type_id
		";
	// 	$sqlr = "SELECT c.*,p.* FROM mineraux c, famille p WHERE c.famille_id=p.id";
	$result = $link->query($sqlr);
 
	if ($result->num_rows > 0) {
		while($row = $result->fetch_assoc()) {
			global $id, $nom, $famille, $image_path;
			$id [] = $row["id"];
			$nom [] = $row["nom"];
			$famille [] = $row["famille_nom"];
			$type [] = $row['type_nom'];
			$image_path [] = $row["image_path"];

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

echo "<table>";
for ($i=0; $i <=sizeof($id);$i++){
	echo "<tr><td>".$id[$i]."</td><td>".$nom[$i]."</td><td>".$famille[$i]."</td><td>".$type[$i]."</td><td>".$image_path[$i]."</td><td></br>";
}

echo "</table>";
echo "</br>";
for ($i=0; $i <=sizeof($id);$i++){
echo "<img src=".$image_path[$i].">";
}

// $row["id"];
// $row["nom"];
// $row["famille_nom"];
// $row["image_path"];


?>




