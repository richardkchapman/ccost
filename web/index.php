#!/usr/bin/php
<html>
  <head>
    <meta http-equiv="refresh" content="60"/>
    <meta NAME="pragma" CONTENT="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <Title>Power imported from grid</title>
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
include "powergraphs.php";
?>
    <p>
     <big>
      Current power imported: <? echo $currentWatts; ?>W, generating <? echo $currentWattsGenerated; ?>W monitored <? echo $currentApp1; ?>W
     </big>
    </p>

    <h2>Previous hour</h2>
    <p><img src="png/power-hour.png" /></p>

    <h2>Previous 6 hours</h2>
    <p><img src="png/power-6hour.png" /></p>

    <h2>Previous 24 hours</h2>
    <p><img src="png/power-day.png" /></p>

    <h2>Previous week</h2>
    <p><img src="png/power-week.png" /></p>

    <h2>Previous month</h2>
    <p><img src="png/power-month.png" /></p>

    <h2>Previous year</h2>
    <p><img src="png/power-year.png" /></p>

  </body>
</html>
