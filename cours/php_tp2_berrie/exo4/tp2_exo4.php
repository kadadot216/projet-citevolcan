<!DOCTYPE html>
<html lang="fr">


<head>
	<meta charset="UTF-8">
	<title>PHP TP2</title>
</head>
<body>
<FORM METHOD="POST" ACTION="<?php echo $_SERVER['PHP_SELF']; ?>">

<h1>Avec quels moyens de transport voyagez vous?</h1>
<?php
session_start();

if (isset($_POST['submit_button'])) { ?>
	<p>Voici la liste avec vos ajouts : </p>
<?php


if (isset($_POST['voyage']))
{
$_SESSION['tableauDepart'] = $_POST['voyage'];

}

/*print_r($_SESSION['tableauDepart']);
echo "<br/>";*/

$stringRajout = trim($_POST['voy']," ");
$tableauRajout = explode(",", $stringRajout);

$_SESSION['tableauDepart'] = array_merge($_SESSION['tableauDepart'],$tableauRajout);

echo "<ul>";
foreach ($_SESSION['tableauDepart'] as $value) {
	echo "<li>" . $value . "</li>";
}
echo "</ul>";

/*print_r($stringRajout);
echo "<br/>";
print_r($tableauRajout);
echo "<br/>";
print_r($_SESSION['tableauDepart']);
echo "<br/>";*/

 } else { ?>
	<p>Le voyage prend de nombreuse formes, que ce soit à travers une ville, à travers un pays, ou autour du monde. Voici une liste de quelques modes communs de transports : </p>
<ul>
	<li> <input type="hidden" name="voyage[]" value="Automobile" />Automobile</li>
	<li> <input type="hidden" name="voyage[]" value="Jet" />Jet</li>
	<li> <input type="hidden" name="voyage[]" value="Ferry" />Ferry</li>
	<li> <input type="hidden" name="voyage[]" value="Métro" />Métro</li>
</ul>

<?php } ?> 


<p>S'îl vous plaît, ajoutez vos préférés, où même imaginaires, les modes locaux de <b>Voyage</b> à la liste, séparés par des virgules : </p>

	
<INPUT type=text name="voy" size="100%" />

<INPUT name="submit_button" type="submit" value="Valider" />

</FORM>



</body>
</html>


