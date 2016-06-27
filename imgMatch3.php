<style type="text/css">
	.tContainer {
		width: 350px;
	}
	.thumb {
		width: 350px;
		height: 100px;
		position: relative;

	}
	.thumb:hover {
		height: 437px;
	}
	.insideThumb tr, .insideThumb td {
		padding: 0;
		margin:0;
		border: 3px;
		background-color: #AAAAAA;
		width: 350px;
	}
	.numero {
		font-size:2em;
		color: #EEE;
		position: absolute; 
		top: 100px;
	}
</style>
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

	

$i=1;
 foreach ($cresults as $value) {
 	if ($i<4){
	echo "<div class='tContainer'><div  class='thumb' style='background: url(".$image_path[$value['id']].");'></div><span class='numero'>".$i."</span><div class='insideThumb'><table><tr><td><p>Nom : ".$nom[$value['id']]."</p></td></tr><tr><td><p>Famille : ".$famille[$value['id']]."</p></td></tr><tr><td><p>diff  : ".$value['result']."</p></td></tr></table>
	</div></div>";
	$i++;
 	}
}


?>
