<?php  

include_once('fetching_ddb.php');

$inputdata = $_POST['dataString'];
$file = 'tmp/match.jpeg';


$inputdata = str_replace(' ','+',$inputdata);
$inputdata = base64_decode($inputdata);
// $imgMatch = imagecreatefromstring($inputdata);

file_put_contents($file, $inputdata);

chmod($file, 0777);

// 



// echo "</br>";
$cresults = array();
for ($i=0; $i <=sizeof($id)-1;$i++){
$handle = popen('opencv_search/match_img32 opencv_search/lena.jpg '.$image_path[$i] ,"r");
$cresults[$i]['result'] = intval(fread($handle, 2096));
$cresults[$i]['id'] = $i;
pclose($handle);
}
// echo $output[0];
// echo $output[0];
// print_r($cresults);
// echo $inputdata;
$cresults = array_filter($cresults);
$cresults = Tri_a_bulle($cresults);

// echo "<br/><br/>";

// print_r($cresults);

// echo "<br/><br/>";

// foreach ($cresults as $value)
// {
// 	echo $value['result']." ";
// }

function Tri_a_bulle($table)
{
	$taille = count($table);

	for ($i=0; $i < $taille; $i++) { 
		for ($j=0; $j < $taille-1-$i; $j++) { 
			if ($table[$j+1] < $table[$j]) {
				echange($table,$j+1,$j);
			}
		}
	}
	return $table;
}


function echange(&$T,$a,$b)
{
	$tmp = $T[$a];
	$T[$a] = $T[$b];
	$T[$b] = $tmp;
}

echo "<br/><br/>";


echo "<table>";
	
echo "<tr> <td>POSITION</td> <td>ID BDD</td> <td>NOM MINERAUX</td> <td>FAMILLE MINERAUX</td> <td>VALEUR PROGRAMME</td><td>IMAGE</td></tr>";
$i=1;
 foreach ($cresults as $value) {
 	if ($i<8){
	echo "<tr><td>".$i."</td><td>".$id[$value['id']]."</td><td>".$nom[$value['id']]."</td><td>".$famille[$value['id']]."</td><td>".$value['result']."</td><td><img width='200' src=".$image_path[$value['id']]."></td></tr>";
	$i++;
 	}
}

echo "</table>";

?>