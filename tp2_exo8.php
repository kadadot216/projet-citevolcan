<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<title>PHP TP2</title>

</head>
<body>


<?php 


$TABLEAU = array(500,200,3,50,1595,15,266);

Affiche($TABLEAU,"Avant");

$NEWTAB = Tri_a_bulle($TABLEAU);
Affiche($NEWTAB,"Après");

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

function Affiche($table,$stade)
{
	echo $stade . " le tri à bulle : <br/>";
	foreach ($table as $value) {
		echo $value . " ";
	}
	echo "<br/>";
/*	var_dump($table);*/
}

 ?>

<!-- fonction Tri_a_bulle(tableau)
DEBUT
taille = taille_du_tableau(tableau)

POUR I=0 a I<taille FAIRE
POUR J=0 a J<taille-1-I FAIRE
SI (tableau[J+1] < tableau[J])
 Echange(tableau,J,I+1)
 FINSI
 FINFAIRE
 FINFAIRE
 FIN

 fonction Echange(tableau,a,b)
 DEBUT
 TMP=tableau[a]
 tableau[a] = tableau[b]
 tableau[b] = TMP
 FIN

 TABLEAU = (1,3,2,8,5,7,4,0)
 NEWTAB = Tri_a_bulle(TABLEAU)

 AFFICHER_TABLEAU(NEWTAB)
 -->



</body>
</html>