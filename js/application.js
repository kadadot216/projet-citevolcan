var imageNr = 0; // Serial number of current image
var finished = new Array(); // References to img objects which have finished downloading
var paused = false;
var histo = 0;
var apachePrefix = "http://192.168.2.4:8080";
var DataURL;

var createImageLayer = function () {
  var img = new Image();
  img.style.position = "absolute";
  img.style.zIndex = -1;
  img.onload = imageOnload;
  /*  img.onclick = imageOnclick;*/
  img.src = apachePrefix + "/?action=snapshot&n=" + (++imageNr);
  var webcam = document.getElementById("webcam");
  webcam.insertBefore(img, webcam.firstChild);
},
imageOnload = function () {
  this.style.zIndex = imageNr; // Image finished, bring to front!
  while (1 < finished.length) {
    var del = finished.shift(); // Delete old image(s) from document
    del.parentNode.removeChild(del);
  }
  finished.push(this);
  if (!paused) createImageLayer();
},
imageOnclick = function () { // Clicking on the image will pause the stream
  paused = !paused;
  if (!paused) createImageLayer();
};

var displayHello = function() {
	alert("hello");
};

function getCanvas(CurrImage) {
  $('#webcam').html("<canvas id='webCanvas' width='640' height='480'></canvas>");
  img = new Image();
  var canvas = document.getElementById('webCanvas');
  var ctx = canvas.getContext('2d');
  var src = apachePrefix + "/?action=snapshot&n=" + CurrImage;
  img.crossOrigin='anonymous';

  img.onload = function() {
    ctx.drawImage(img, 0, 0,640,480);
    localStorage.setItem( "savedImageData", canvas.toDataURL("image/png") );
  };
  img.src = src;
  if ( img.complete || img.complete === undefined ) {
    img.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
    img.src = src;
}
}

$(document).ready(function() {

  $("#webcam").animate({'height':'480px',
    'width':'640px',
    'margin':'0 40%'},
    1000);
  createImageLayer();
});

$(".hero").on("click","a.capture", function(event) {
  event.preventDefault();
  var insert = $(this).parent();
  var btnOui = $("<a href='#' class='btn-perso2 hollow success button'>Oui</a>");
  var btnNon = $("<a href='#' class='btn-perso2 hollow alert button'>Non</a>");
  var message = $("<p>Voulez-vous garder cette capture?</p>");
  getCanvas(imageNr);
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
      finished = new Array(); //Réinitialise le array à zéro.
      createImageLayer();
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

