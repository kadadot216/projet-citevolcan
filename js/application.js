var imageNr = 0; // Serial number of current image
var finished = []; // References to img objects which have finished downloading
var paused = false;
var histo = 0;
var apachePrefix = window.location.protocol + "//" + window.location.hostname + ":8080";
var DataURL;

var getStream = function()
{
  $('#webcam').html("<img src='"+apachePrefix+"/?action=stream' />");
};

/*var getSnap = function()
{
  $('#webcam').html("<img src='"+apachePrefix+"/?action=snapshot' />");
};*/

function getCanvas() {

  var URL = apachePrefix+"/?action=snapshot";
  $.ajax({
        type:'POST',
        url:'img.php',
        data:{dataURL:URL},
    success: function(data){
    $('#webcam').html(data);

    },
    error: function(err) {
      console.table(err);

    }



  });
}

/*function drawCanvas(text)
{
    $('#webcam').html("<canvas id='MyCanvas'></canvas>");
    var myCanvas = document.getElementById('MyCanvas');
    var ctx = myCanvas.getContext('2d');
    var img = new Image();
    img.onload = function(){
    ctx.drawImage(img,0,0,163,120); // Or at whatever offset you like
};
img.src = text;
}*/

$(document).ready(function() {

    getStream();
  $("#webcam").animate({'height':'480px',
    'width':'640px',
    'margin':'0 40%'},
    1000);

});

$(".hero").on("click","a.capture", function(event) {
  event.preventDefault();
  var insert = $(this).parent();
  var btnOui = $("<a href='#' class='btn-perso2 hollow success button'>Oui</a>");
  var btnNon = $("<a href='#' class='btn-perso2 hollow alert button'>Non</a>");
  var message = $("<p>Voulez-vous garder cette capture?</p>");
  getCanvas();
  $(this).hide(200, function() {
    insert.animate({'top':'50px'});
    $(btnNon).prependTo(insert).hide().slideDown();
    $(btnOui).prependTo(insert).hide().slideDown();
    message.prependTo(insert).hide().slideDown();
  }).ready(function()
  {
    $(btnNon).on("click", function()
    {
      $(this).slideUp(function(){$(this).remove();});
      $(btnOui).slideUp(function(){$(this).remove();});
      $(message).slideUp(function(){$(this).remove();});
      insert.animate({'top':'40%'});
      $('a.capture').slideDown();
      finished = []; //Réinitialise le array à zéro.
      getStream();
    });
    $(btnOui).on("click", function()
    {
      $(this).slideUp(function(){$(this).remove();});
      $(btnNon).slideUp(function(){$(this).remove();});
      $(message).slideUp(function(){$(this).remove();});
      insert.animate({'top':'40%'});
      $('a.capture').slideDown();
    });

  });
});

