<?php
$myFile = "/tmp/ccost/current.log";
$fh = fopen($myFile, 'r');
$currentWattsImported = (integer) fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentgenerating.log";
$fh = fopen($myFile, 'r');
$currentWattsGenerated = (integer) fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentapp1.log";
$fh = fopen($myFile, 'r');
$currentWattsApp1 = (integer) fgets($fh);
fclose($fh);
$currentWattsTotal = $currentWattsImported + $currentWattsGenerated;

echo "<p>";
echo " <big>";
echo "  Current power total: <b>",$currentWattsTotal, "W</b>";
echo "  imported: ",$currentWattsImported, "W";
echo "  generated: ",$currentWattsGenerated, "W";
echo " </big>";
echo "</p>";
?>


