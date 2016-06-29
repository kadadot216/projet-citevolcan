<style type="text/css">
#domresults {
		width: 350px;
		float:right;
		margin-right: 20%;
		margin-top: -5%;
	}
	.thumb {
		height: 80px;
		font-size:1.3em;
		color: white;
		font: italic bold georgia, sans-serif;
		padding-left: 20px;
		padding-top: 20px;
	}
	.thumb:hover {
		height: 400px;
	}
	.insideThumb table,
	.insideThumb tr,
	.insideThumb td{
		border-collapse:separate !important;
		border-spacing: 0 !important;
	}
	.insideThumb td{
		background-color: rgba(221,221,221,0.5) !important;
		border-collapse: separate !important;
		border: 0 !important;
		margin: 0px !important;
		padding: 0px !important;
	}
	.tNom{
		font-size:1.3em;
		font: arial, sans-serif;
		color: #222;
	}
	.tFam{
		font-size:1.1em;
		font: italic bold georgia, sans-serif;
		color: #E40;
	}
	.tType{
		font-size:1em;
		font: italic georgia, sans-serif;
		color: #33E;
	}
	.tDiff{
		font-size:.9em;
		font: arial, sans-serif;
		color: #844;
	}
</style>
<?php  

include_once('fetching_ddb.php');

$inputdata = $_POST['dataString'];
$file = 'img/tmp/match.jpeg';


$inputdata = str_replace(' ','+',$inputdata);
$inputdata = base64_decode($inputdata);
// $imgMatch = imagecreatefromstring($inputdata);

file_put_contents($file, $inputdata);

chmod($file, 0777);

// 



// echo "</br>";
$cresults = array();
for ($i=0; $i <=sizeof($id)-1;$i++){
$handle = popen('opencv/match_img32 '.$file.' '.$image_path[$i] ,"r");
$cresults[$i]['result'] = intval(fread($handle, 2096));
$cresults[$i]['id'] = $i;
pclose($handle);
}

$cresults = array_filter($cresults);
$cresults = triClassement($cresults);

function triClassement($table)
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

	
echo "<div id='domresults'>";
$i=1;
 foreach ($cresults as $value) {
 	if ($i<4){
	echo "<div class='tContainer'><div  class='thumb' style='background: url(".$image_path[$value['id']].") no-repeat;'> ".$i."</div><div class='insideThumb'><table><tr><td><p class='tNom'>Nom : ".$nom[$value['id']]."</p></td></tr><tr><td><p class='tFam'>Famille : ".$famille[$value['id']]."</p></td></tr><tr><td><p class='tType'>Type : ".$type[$value['id']]."</p></td></tr><tr><td><p class='tDiff'>diff  : ".$value['result']."</p></td></tr></table>
	</div></div>";
	$i++;
 	}
}
echo "<td style='padding:0; width=350px;'><button class='info button' id='classement' style='font-size: 1.2rem; padding: 0.2em 4.5em; margin:0;'>Voir le tableau complet</button></td>";
echo "</div>";

include_once("display_table.php");

?>
