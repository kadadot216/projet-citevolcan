<?php  
echo "<div id='fulltable'><table>";
	
echo "<tr><td>CLASSEMENT</td><td>ID BDD</td><td>NOM MINERAUX</td><td>FAMILLE MINERAUX</td><td>TYPE MINERAUX</td><td>SCORE DIFF</td><td>IMAGE</td></tr>";
$i=1;
 foreach ($cresults as $value) {
	echo "<tr><td>".$i."</td><td>".$id[$value['id']]."</td><td>".$nom[$value['id']]."</td><td>".$famille[$value['id']]."</td><td>".$type[$value['id']]."</td><td>".$value['result']."</td><td><img width='200' src=".$image_path[$value['id']]."></td></tr>";
	$i++;
}

echo "<tr style='display:table-row'><td colspan='7'><button class='alert hollow button' id='recommencer' style='font-size: 2rem; padding: 0.2em 4.5em; margin:0;'>RETOUR</button></td></tr>";
echo "</table></div>";

?>