<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL);
$inputdata = $_POST['dataString'];
 $bright=$_POST['brightness'];
 $contr=$_POST['contrast'];
 $nettete=$_POST['nett'];
 $G = $_POST['greyscale'];
 $N = $_POST['negate'];

$inputdata = base64_decode($inputdata);

$imgJpeg = imagecreatefromstring($inputdata);


if ($G == 1)
{
    imagefilter($imgJpeg, IMG_FILTER_GRAYSCALE);
}

if ($N == 1)
{
    imagefilter($imgJpeg, IMG_FILTER_NEGATE );

}

imagefilter($imgJpeg, IMG_FILTER_BRIGHTNESS, $bright);
imagefilter($imgJpeg, IMG_FILTER_CONTRAST,  -$contr);
imagefilter($imgJpeg, IMG_FILTER_SMOOTH,  $nettete);





if ($imgJpeg !== false) {
    ob_start();
    imagejpeg($imgJpeg);
    $contents =  ob_get_contents();
    ob_end_clean();
    echo "data:image/jpeg;base64,".base64_encode($contents);
    imagedestroy($imgJpeg);


}
else {
    echo 'An error occurred.';
}
?>
