var imageNr = 0; // Serial number of current image
var finished = []; // References to img objects which have finished downloading
var paused = false;
var histo = 0;
var apachePrefix = window.location.protocol + "//" + window.location.hostname + ":8080";
var DataURL;

var getStream = function()
{
  $('#webcam').html("<img src='fff.jpeg' />");
};

/*var getSnap = function()
{
  $('#webcam').html("<img src='"+apachePrefix+"/?action=snapshot' />");
};*/

function getCanvas() {

  var URL = "f33.jpg";
  // ça va servir pour créer un historique avec une BDD
  $.ajax({
        type:'POST',
        url:'img.php',
        data:{dataURL:URL},
    success: function(data){
      drawCanvas(data);
      DataURL = data.replace("data:image/jpeg;base64,","");
    },
    error: function(err) {
      console.table(err);

    }



  });
}

function drawCanvas(text)
{
    $('#webcam').html("<canvas id='MyCanvas' height='480' width='640'></canvas>");
    var myCanvas = document.getElementById('MyCanvas');
    var ctx = myCanvas.getContext('2d');
    var img = new Image();
    img.onload = function(){
    ctx.drawImage(img,0,0); // Or at whatever offset you like
};
img.src = text;
}

$(document).ready(function() {

    getStream();
  $("#webcam").animate({'height':'480px',
    'width':'640px',
    'margin':'0 40%'},
    1000);

});

$(".hero").on("click","a.capture", function(event) {
  event.preventDefault();
  var $insert = $(this).parent();
  var $btnOui = $("<a href='#' class='btn-perso2 hollow success button'>Oui</a>");
  var $btnNon = $("<a href='#' class='btn-perso2 hollow alert button'>Non</a>");
  var $message = $("<p>Voulez-vous garder cette capture?</p>");
  getCanvas();
  $(this).hide(200, function() {
    $insert.animate({'top':'50px'});
    $btnNon.prependTo($insert).hide().slideDown();
    $btnOui.prependTo($insert).hide().slideDown();
    $message.prependTo($insert).hide().slideDown();
  }).ready(function()
  {
    $($btnNon).on("click", function()
    {
      $(this).slideUp(function(){$(this).remove();});
      $btnOui.slideUp(function(){$(this).remove();});
      $message.slideUp(function(){$(this).remove();});
      $insert.animate({'top':'40%'});
      $('a.capture').slideDown();
      finished = []; //Réinitialise le array à zéro.
      getStream();
    });
    $($btnOui).on("click", function()
    {
      $(this).slideUp(function(){$(this).remove();});
      $btnNon.slideUp(function(){$(this).remove();});
      $message.slideUp(function(){
        $(this).remove();
        changeTitle(1);
        appendBloc();
        Slider();
        ZoomImage();
      });
    });

  });
});


function changeTitle(param)
{
  if (param === 1)
  {
    $("h1").text("2 - Effectuer des changements");
  }
  else if (param === 2)
    {$("h1").text("3 - Analyse de formes");}
}

function appendBloc()
{
  var superDiv = 
"<div class='filterField'>" +
"<label>Price:</label>" +
"<table>" +
"  <tr>" +
"    <td><input type='range' name='bright' id='bright' min='-100' max='100' value='100' /></td>" +
"    <td><div class='rangeValue'><div id='valueBright'>0</div> Luminosité</div></td>" +
"  </tr>" +
"  <tr>" +
"    <td><input type='range' name='contrast' id='contrast' min='-100' max='100' value='100' /></td>" +
"    <td><div class='rangeValue'><div id='valueContr'>0</div> Contraste</div></td>" +
"  </tr>" +
"  <tr>" +
"    <td><input type='range' name='nett' id='nett' min='-6' max='6' value='6' /></td>" +
"    <td><div class='rangeValue'><div id='valueNett'>0</div> Nettetté</div></td>" +
"  </tr>" +
"  <tr>" +
"  <td><input type='checkbox' name='checkGreyscale' id='checkGreyscale' /></td>" +
"  <td>Balance des blancs</td>" +
"</tr>" +
"<tr>" +
"  <td><input type='checkbox' name='checkNegate' id='checkNegate' /></td>" +
"  <td>Négatif</td>" +
"</tr>" +
"<tr>" +
"  <td colspan='2' style='padding:0;'><button class='success button etSValid' style='font-size: 1.7rem; padding: 0.2em 4.5em; margin:0;'>Valider</button></td>" +
"</tr>" +
"<tr>" +
"  <td colspan='2' style='padding:0;'><button class='alert button etSRetour' style='font-size: 1.7rem; padding: 0.2em 4.5em; margin:0;'>Retour</button></td>" +
"</tr>" +
"</table>" +
"</div>";

  $(".next-to").append(superDiv);
  $(".next-to").css({'top':'100%'},400).animate({'top':'5%'},400);

}

function Slider() {

  $(':checkbox:checked').prop('checked',false);
  
   var brightVal = $('#bright').val(0),
       contrVal = $('#contrast').val(0),
       nettVal = $('#nett').val(0),
       greyscale=0, negate=0;


$("#bright, #contrast, #nett, #checkGreyscale, #checkNegate").on('change', function () {

  Actualiser();

});// fin de onchange()

$(".etSValid").on('click', function () {
  alert("TESTING SOMETHING");
});
$(".etSRetour").on('click', function () {
  alert("Je retourne");
});

} // fin slider()

function Actualiser()
{

   brightVal = $('#bright').val();
   contrVal = $('#contrast').val();
   nettVal = $('#nett').val();

    if( $( "#checkGreyscale" ).is(':checked')) {greyscale = 1; } 
    else {greyscale = 0; }

    if( $( "#checkNegate" ).is(':checked')) {negate = 1; } 
    else {negate = 0; }


   $("#valueBright").html(brightVal);
   $("#valueContr").html(contrVal);
   $("#valueNett").html(nettVal);


                $.ajax({
            type:"POST",
            url: "data.php",
            data: {dataString: DataURL,
                  brightness: brightVal,
                  contrast: contrVal,
                  nett: nettVal,
                  greyscale: greyscale,
                  negate: negate                  
                  },
            success: function(data){
              console.log(data);
              drawCanvas(data);
            },
            error: function(err){
              console.log(err);
            }

    });

 }

function ZoomImage()
{
  var divZoomer = "<div class='zoom'>" +
"        Scale X : " +
"      <input type='range' id='scalexy' value='0' min='0' max='100' /><span id='scalexyVal'></span>" +
"      <button class='button success' id='target'>Resize Image</button>" +
"</div>";

  $(divZoomer).appendTo("#ensemble");

$(function(){
   var scaley = $('#scalexy').val();
   var scalex = $('#scalexy').val();
   var myJcrop = $.Jcrop('#MyCanvas', {
       aspectRatio: 1,
       onSelect: updateCoords,
       boxWidth: scalex, 
       boxHeight: scaley
   });

   $('#target').click(function() {
      myJcrop.destroy();
      scalex = $('#scalexy').val();
      scaley = $('#scalexy').val();
      myJcrop = $.Jcrop('#MyCanvas', {
          aspectRatio: 1,
          onSelect: updateCoords,
          boxWidth: scalex, 
          boxHeight: scaley
      });
      console.log(scaley + scalex);
      $("#scalexyVal").html(scaley);
   });

 });
}

