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
$myFile = "/tmp/ccost/currentexport.log";
$fh = fopen($myFile, 'r');
$currentWattsExported = (integer) fgets($fh);
fclose($fh);

$myFile = "/tmp/ccost/currentapp4.log";
$fh = fopen($myFile, 'r');
$currentWattsApp4 = (integer) fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentapp5.log";
$fh = fopen($myFile, 'r');
$currentWattsApp5 = (integer) fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentapp6.log";
$fh = fopen($myFile, 'r');
$currentWattsApp6 = (integer) fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentcct7.log";
$fh = fopen($myFile, 'r');
$currentWattsCct7 = (integer) fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentcct8.log";
$fh = fopen($myFile, 'r');
$currentWattsCct8 = (integer) fgets($fh);
fclose($fh);
$myFile = "/tmp/ccost/currentcct9.log";
$fh = fopen($myFile, 'r');
$currentWattsCct9 = (integer) fgets($fh);
fclose($fh);


$currentWattsTotal = $currentWattsImported + $currentWattsGenerated;
if ($currentWattsImported==0)
  $currentWattsTotal = $currentWattsTotal - currentWatsExported;
echo "<p>";
echo " <big>";
echo "  Current power total: <b>",$currentWattsTotal, "W</b>";
echo "  imported: ",$currentWattsImported, "W";
echo "  generated: ",$currentWattsGenerated, "W";
echo "  exported: ",$currentWattsExported, "W";

echo "  app1: ",$currentWattsApp1, "W";
echo "  app4: ",$currentWattsApp4, "W";
echo "  app5: ",$currentWattsApp5, "W";
echo "  app6: ",$currentWattsApp6, "W";
echo "  cct7: ",$currentWattsCct7, "W";
echo "  cct8: ",$currentWattsCct8, "W";
echo "  cct9: ",$currentWattsCct9, "W";
echo " </big>";
echo "</p>";
?>


