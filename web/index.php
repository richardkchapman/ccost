#!/usr/bin/php
<html>
  <head>
    <meta http-equiv="refresh" content="60"/>
    <meta NAME="pragma" CONTENT="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <Title>Power usage by source</title>
    <style>
      body {
        font-family: calibri,verdana,sans-serif;
        font-size: 12px;
      }
      h2 {
        background: #ccccff;
        border-top: 1px solid #6666cc;
      }
    </style>
  </head>
  <body>
    <h1>Power usage by source</h1>
<?php
include "currentvalues.php";
include "sourcegraphs.php";
?>
    <p>
     <a href="index.php">By source</a>&nbsp;<a href="byuse.php">By appliance</a>
    </p><p>
     <big>
      Current power total: <b><? echo $currentWattsTotal; ?>W</b> imported: <? echo $currentWattsImported; ?>W, generating <? echo $currentWattsGenerated; ?>W monitored <? echo $currentWattsApp1; ?>W
     </big>
    </p>

    <h2>Previous hour</h2>
    <p><img src="png/source-1h.png" /></p>

    <h2>Previous 6 hours</h2>
    <p><img src="png/source-6h.png" /></p>

    <h2>Previous 24 hours</h2>
    <p><img src="png/source-1d.png" /></p>

    <h2>Previous week</h2>
    <p><img src="png/source-1w.png" /></p>

    <h2>Previous month</h2>
    <p><img src="png/source-1month.png" /></p>

    <h2>Previous year</h2>
    <p><img src="png/source-1y.png" /></p>

  </body>
</html>
