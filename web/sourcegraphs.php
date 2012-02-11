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
exec ("./simplesource.sh 1h");
exec ("./simplesource.sh 6h");
exec ("./minmaxsource.sh 1d");
exec ("./minmaxsource.sh 1w");
exec ("./minmaxsource.sh 1month");
exec ("./minmaxsource.sh 1y");
?>
