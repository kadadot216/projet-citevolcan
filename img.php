<?php
$url = $_POST['dataURL'];
/*
Conduct image verification, etc.
*/
$data = file_get_contents($url);
/*$img_ext = get_ext($url);*/ //Create function "get_ext()" that gets file extension
header('Content-type: image/jpeg');
echo "<img src='data:image/jpeg;base64,".base64_encode($data)."' />";

?>