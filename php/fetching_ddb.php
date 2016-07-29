<?php
function connectDB($localhost,$login,$passwd,$dbb ) {
	$conn = new mysqli($localhost, $login, $passwd, $dbb);
	if  ($conn->connect_error === TRUE) {
	echo "Erreur de connection: ". $conn->connect_error . "\n";
	} else {
	mysqli_set_charset($conn,"utf8");
	return $conn;
	}
}

function fetchDB($link) {
	$sqlr = "SELECT mineraux.E_id,mineraux.nom,famille.famille_nom,type.type_nom,mineraux.image_path 
		FROM mineraux 
		LEFT JOIN famille 
		ON mineraux.famille_id=famille.f_id
		LEFT JOIN type
		ON mineraux.type_id=type.t_id
		";
	$result = $link->query($sqlr);
 
	if ($result->num_rows > 0) {
		while($row = $result->fetch_assoc()) {
			global $id, $nom, $famille, $image_path,$type;
			$id[] = $row["id"];
			$nom[] = $row["nom"];
			$famille[] = $row["famille_nom"];
			$type[] = $row['type_nom'];
			$image_path[] = $row["image_path"];

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




