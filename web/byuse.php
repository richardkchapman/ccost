#!/usr/bin/php
<html>
  <head>
    <meta http-equiv="refresh" content="60"/>
    <meta NAME="pragma" CONTENT="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <Title>Power usage by appliance</title>
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
    <h1>Power usage by appliance</h1>
    <p>
     <a href="index.php">By source</a>&nbsp;<a href="byuse.php">By appliance</a>
    </p>
    <?php include "currentvalues.php"; ?>

<?php
include "usegraphs.php";
?>
    <h2>Previous hour</h2>
    <p><img src="png/use-1h.png" /></p>

    <h2>Previous 6 hours</h2>
    <p><img src="png/use-6h.png" /></p>

    <h2>Previous 24 hours</h2>
    <p><img src="png/use-1d.png" /></p>

    <h2>Previous week</h2>
    <p><img src="png/use-1w.png" /></p>

    <h2>Previous month</h2>
    <p><img src="png/use-1month.png" /></p>

    <h2>Previous year</h2>
    <p><img src="png/use-1y.png" /></p>

  </body>
</html>
