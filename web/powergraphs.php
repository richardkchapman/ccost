<?php
$myFile = "/tmp/ccost/current.log";
$fh = fopen($myFile, 'r');
$currentWatts = fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentgenerating.log";
$fh = fopen($myFile, 'r');
$currentWattsGenerated = fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentapp1.log";
$fh = fopen($myFile, 'r');
$currentApp1 = fgets($fh);
fclose($fh);
exec ("./powerhour.sh");
exec ("./power6hour.sh");
exec ("./powerday.sh");
exec ("./powerweek.sh");
exec ("./powermonth.sh");
exec ("./poweryear.sh");
?>
