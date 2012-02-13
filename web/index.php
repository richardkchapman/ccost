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
    <p>
     <a href="index.php">By source</a>&nbsp;<a href="byuse.php">By appliance</a>
    </p>
    <?php include "currentvalues.php"; ?>

    <?php exec ("./simplesource.sh 1h"); ?>
    <h2>Previous hour</h2>
    <p><img src="png/source-1h.png" /></p>

    <?php exec ("./simplesource.sh 6h"); ?>
    <h2>Previous 6 hours</h2>
    <p><img src="png/source-6h.png" /></p>

    <?php exec ("./minmaxsource.sh 1d"); ?>
    <h2>Previous 24 hours</h2>
    <p><img src="png/source-1d.png" /></p>

    <?php exec ("./simplesource.sh 1w --step 3600"); ?>
    <h2>Previous week, by hour</h2>
    <p><img src="png/source-1w.png" /></p>

    <?php exec ("./simplesource.sh 1month --step 86400"); ?>
    <h2>Previous month, by day</h2>
    <p><img src="png/source-1month.png" /></p>

    <?php exec ("./simplesource.sh 1y --step 604800"); ?>
    <h2>Previous year, by week</h2>
    <p><img src="png/source-1y.png" /></p>

  </body>
</html>
