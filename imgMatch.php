<?php  
$inputdata = $_POST['dataString'];
$file = './match.jpeg';


$inputdata = str_replace(' ','+',$inputdata);
$inputdata = base64_decode($inputdata);
// $imgMatch = imagecreatefromstring($inputdata);

file_put_contents($file, $inputdata);

chmod($file, 0777);



exec('opencv_search/match_img '.$file.' opencv_search/output.jpg',$output);
// echo $output[0];
echo $output[0];
// echo $inputdata;

// unlink($file);


?>