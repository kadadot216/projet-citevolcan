<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="UTF-8">
	<title>PHP TP2</title>
</head>
<body>

<h1>Quel temps fait-il?</h1>

<FORM METHOD="POST" ACTION="temps.php">
	
<table>
<tr>
<td>Ville : 
			 <INPUT type=text name="inputLocal[]">
</td>

	<td>Mois : 
			 <INPUT type=text name="inputLocal[]">
	</td>

	<td>Année : 
		<INPUT type=text name="inputLocal[]">
	</td>
</tr>
</table>


<p>S'îl vous plaît, choissez les types de temps que vous aviez eu dans la liste ci-dessous. Choisissez toutes les réponses appropriés! </p>

<ul>
	<li><INPUT type=checkbox value="Soleil" name="temps[]" ><label>Soleil</label></li>
	<li><INPUT type=checkbox value="Nuages" name="temps[]" ><label>Nuages</label></li>
	<li><INPUT type=checkbox value="Pluie" name="temps[]"><label>Pluie</label></li>
	<li><INPUT type=checkbox value="Grêle" name="temps[]"><label>Grêle</label></li>
	<li><INPUT type=checkbox value="Verglas" name="temps[]"><label>Verglas</label></li>
	<li><INPUT type=checkbox value="Neige" name="temps[]"><label>Neige</label></li>
	<li><INPUT type=checkbox value="Vent" name="temps[]"><label>Vent</label></li>
	<li><INPUT type=checkbox value="Froid" name="temps[]"><label>Froid</label></li>
	<li><INPUT type=checkbox value="Chaleur" name="temps[]"><label>Chaleur</label> </li>
</ul>

<INPUT type="submit" value="Envoyer">

</FORM>



</body>
</html>




