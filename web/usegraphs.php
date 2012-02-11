<?php
$myFile = "/tmp/ccost/current.log";
$fh = fopen($myFile, 'r');
$currentWattsImported = fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentgenerating.log";
$fh = fopen($myFile, 'r');
$currentWattsGenerated = fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentapp1.log";
$fh = fopen($myFile, 'r');
$currentApp1 = fgets($fh);
fclose($fh);
exec ("./simpleuse.sh 1h");
exec ("./simpleuse.sh 6h");
exec ("./simpleuse.sh 1d");
exec ("./simpleuse.sh 1w");
exec ("./simpleuse.sh 1month");
exec ("./simpleuse.sh 1y");
?>
