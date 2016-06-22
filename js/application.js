var imageNr = 0; // Serial number of current image
var finished = []; // References to img objects which have finished downloading
var paused = false;
var histo = 0;
var apachePrefix = window.location.protocol + "//" + window.location.hostname + ":8080";
var DataURL;

var getStream = function()
{
  $('#webcam').html("<img src='roche.jpg' />");
};

var getCanvas = function() {
  var URL = "roche.jpg";
  // ça va servir pour créer un historique avec une BDD
  $.ajax({
    type: 'POST',
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
};

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

function Slider() {

  $(':checkbox:checked').prop('checked',false);
  
  var brightVal = $('#bright').val(0),
  contrVal = $('#contrast').val(0),
  nettVal = $('#nett').val(0),
  greyscale=0, negate=0;
Actualiser();

  $("#bright, #contrast, #nett, #checkGreyscale, #checkNegate").on('change', function () {

Actualiser();

});// fin de onchange()


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

var loadApp = function() {
    $(".hero > .wrap").load("app.html",function(){
      loadAllDOM();
  getStream();

  $("#webcam").animate({'height':'480px',
    'width':'640px',
    'margin':'0 40%'},
    1000);
    }); 
};

$(document).ready(function() {

loadApp();
  
$('.mainApp').on('click', loadApp);
    
$('.superVision').on('click', function(){
  $(".hero > .wrap").load("supervisation.html");
});

$('.ongletDoc').on('click', function(){
  $(".hero > .wrap").load("docmain.html");
});


});