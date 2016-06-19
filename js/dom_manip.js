
$(function() {

	var $btnCapture = $("div.next-to > a.capture"),
		$divNextTo =  $("div.next-to"),
	$btnOui = $("<a href='#' class='btn-perso2 hollow success button'>Oui</a>"),
	$btnNon = $("<a href='#' class='btn-perso2 hollow alert button'>Non</a>"),
	$message = $("<p>Voulez-vous garder cette capture?</p>");

	var superDiv = 
	superDiv += "<div class='filterField'>";
	superDiv += "<table>";
	superDiv += "  <tr>";
	superDiv += "    <td><input type='range' name='bright' id='bright' min='-100' max='100' value='100' /></td>";
	superDiv += "    <td><div class='rangeValue'><div id='valueBright'>0</div> Luminosité</div></td>";
	superDiv += "  </tr>";
	superDiv += "  <tr>";
	superDiv += "    <td><input type='range' name='contrast' id='contrast' min='-100' max='100' value='100' /></td>";
	superDiv += "    <td><div class='rangeValue'><div id='valueContr'>0</div> Contraste</div></td>";
	superDiv += "  </tr>";
	superDiv += "  <tr>";
	superDiv += "    <td><input type='range' name='nett' id='nett' min='-6' max='6' value='6' /></td>";
	superDiv += "    <td><div class='rangeValue'><div id='valueNett'>0</div> Nettetté</div></td>";
	superDiv += "  </tr>";
	superDiv += "  <tr>";
	superDiv += "  <td><input type='checkbox' name='checkGreyscale' id='checkGreyscale' /></td>";
	superDiv += "  <td>Balance des blancs</td>";
	superDiv += "</tr>";
	superDiv += "<tr>";
	superDiv += "  <td><input type='checkbox' name='checkNegate' id='checkNegate' /></td>";
	superDiv += "  <td>Négatif</td>";
	superDiv += "</tr>";
	superDiv += "<tr>";
	superDiv += "  <td colspan='2' style='padding:0;'><button class='success button etSValid' style='font-size: 1.7rem; padding: 0.2em 4.5em; margin:0;'>Valider</button></td>";
	superDiv += "</tr>";
	superDiv += "<tr>";
	superDiv += "  <td colspan='2' style='padding:0;'><button class='alert button etSRetour' style='font-size: 1.7rem; padding: 0.2em 4.5em; margin:0;'>Retour</button></td>";
	superDiv += "</tr>";
	superDiv += "</table>";
	superDiv += "</div>";


	$btnCapture.on("click", function(){
		getCanvas();
		yesNoConfirmation();
	});

	$($btnNon).on("click", retourEtapeOne);
	$($btnOui).on("click", goToEtapeTwo);

	$(".etSValid").on('click', function () {
		alert("Test OK");
	});
	$(".etSRetour").on('click', function () {
		$btnCapture.animate({'right':'120%'});
		$divNextTo.animate({'top':'50px'}).show();
		retourEtapeOne();
	});


	function yesNoConfirmation(){
		/*		alert("YOLO")*/
		/*	  event.preventDefault();*/
		var divControle = $divNextTo;
		$btnCapture.hide(200, function() {
			$divNextTo.animate({'top':'50px'});
			$btnNon.prependTo(divControle).hide().slideDown();
			$btnOui.prependTo(divControle).hide().slideDown();
			$message.prependTo(divControle).hide().slideDown();
		});
	}


	function retourEtapeOne(){
		$("h1").text("1 - Réaliser une capture");
		$btnNon.slideUp(function(){$(this).hide();});
		$btnOui.slideUp(function(){$(this).hide();});
		$message.slideUp(function(){$(this).hide();});
		$divNextTo.animate({'top':'40%'});
		$btnCapture.slideDown();
	      finished = []; //Réinitialise le array à zéro.
	      getStream();
	  }


	  function goToEtapeTwo(){
	  	$btnOui.slideUp(function(){$(this).hide();});
	  	$btnNon.slideUp(function(){$(this).hide();});
	  	$btnCapture.animate({'right':'120%'});
	  	$message.slideUp(function(){
	  		$(this).hide();
	  		$("h1").text("2 - Effectuer des changements");
	  		$divNextTo.append(superDiv)
	  		.css({'top':'130%','right':'70%'},400).animate({'top':'5%'},400);
	  		Slider();
	  		ZoomImage();
	  	});
	  }


	}());