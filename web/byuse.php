#!/usr/bin/php
<html>
  <head>
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
  <script type="text/javascript">
    function submitForm()
    {
     document.byuse.submit();
    }
    function doLoad()
    {
      setTimeout( "submitForm()", 60*1000 );
    }
  </script>
  <body onLoad="doLoad()">
   <form name="byuse" action="byuse.php" method="post">
    <h1>Power usage by appliance</h1>
    <p>
     <a href="index.php">By source</a>&nbsp;<a href="byuse.php">By appliance</a>
    </p>
    <?php include "currentvalues.php";
     $gen = $_POST["gen"];
     if ($gen=="no")
        $param = $param . " --nogen";
     $export = $_POST["export"];
     if ($export=="no")
        $param = $param . " --noexport";
     $car = $_POST["car"];
     if ($car=="no")
        $param = $param . " --nocar";
     $drier = $_POST["drier"];
     if ($drier=="no")
        $param = $param . " --nodrier";
     $fridge = $_POST["fridge"];
     if ($fridge=="no")
        $param = $param . " --nofridge";
     $tv = $_POST["tv"];
     if ($tv=="no")
        $param = $param . " --notv";
     $lighting = $_POST["lighting"];
     if ($lighting=="no")
        $param = $param . " --nolighting";
     $sock1 = $_POST["sock1"];
     if ($sock1=="no")
        $param = $param . " --nosock1";
     $sock2 = $_POST["sock2"];
     if ($sock2=="no")
        $param = $param . " --nosock2";
#     $rightUnits = "--right-axis 1.3:0 --right-axis-label 'Pounds/Year'"; 
     $rightUnits = "--right-axis 0.356:0 --right-axis-label 'Pence/day'";
     echo "select = $select - $param<br/>";
    ?>
    <font color="#0000ff">
    <input type="hidden" name="gen" value="no"/>
    <input type="checkbox" name="gen" value="yes" <?php if ($gen!="no") echo "checked=\"checked\""; ?> /> Include generation<br/>
    </font>
    <font color="#c0ffc0">
    <input type="hidden" name="export" value="no"/>
    <input type="checkbox" name="export" value="yes" <?php if ($export!="no") echo "checked=\"checked\""; ?> /> Include export<br/>
    </font>
    <font color="#00c000">
    <input type="hidden" name="car" value="no"/>
    <input type="checkbox" name="car" value="1" <?php if ($car!="no") echo "checked=\"checked\""; ?> /> Include car<br/>
    </font>
    <font color="#ff0000">
    <input type="hidden" name="drier" value="no"/>
    <input type="checkbox" name="drier" value="1" <?php if ($drier!="no") echo "checked=\"checked\""; ?> /> Include tumble drier<br/>
    </font>
    <font color="#coffff">
    <input type="hidden" name="fridge" value="no"/>
    <input type="checkbox" name="fridge" value="1" <?php if ($fridge!="no") echo "checked=\"checked\""; ?> /> Include freezer<br/>
    </font>
    <font color="#ff00ff">
    <input type="hidden" name="tv" value="no"/>
    <input type="checkbox" name="tv" value="1" <?php if ($tv!="no") echo "checked=\"checked\""; ?> /> Include tv/freesat<br/>
    </font>
    <font color="#ffff00">
    <input type="hidden" name="lighting" value="no"/>
    <input type="checkbox" name="lighting" value="1" <?php if ($lighting!="no") echo "checked=\"checked\""; ?> /> Include lighting<br/>
    </font>
    <font color="#404040">
    <input type="hidden" name="sock1" value="no"/>
    <input type="checkbox" name="sock1" value="1" <?php if ($sock1!="no") echo "checked=\"checked\""; ?> /> Include socket circuit 1<br/>
    </font>
    <font color="#808080">
    <input type="hidden" name="sock2" value="no"/>
    <input type="checkbox" name="sock2" value="1" <?php if ($sock2!="no") echo "checked=\"checked\""; ?> /> Include socket circuit 2<br/>
    </font>
    <input type="submit" value="Reload"/><br/>
    <?php exec ("./simpleuse.sh 10m $param $rightUnits"); ?>
    <h2>Previous 10 minutes</h2>
    <p><img src="png/use-10m.png" /></p>

    <?php exec ("./simpleuse.sh 1h $param $rightUnits"); ?>
    <h2>Previous hour</h2>
    <p><img src="png/use-1h.png" /></p>

    <?php exec ("./simpleuse.sh 6h $param $rightUnits"); ?>
    <h2>Previous 6 hours</h2>
    <p><img src="png/use-6h.png" /></p>

    <?php exec ("./simpleuse.sh 1d $param $rightUnits"); ?>
    <h2>Previous 24 hours</h2>
    <p><img src="png/use-1d.png" /></p>

    <?php exec ("./simpleuse.sh 1w $param --step 600 $rightUnits"); ?>
    <h2>Previous week</h2>
    <p><img src="png/use-1w.png" /></p>

    <?php exec ("./simpleuse.sh 1month $param --step 86400 $rightUnits"); ?>
    <h2>Previous month, by day</h2>
    <p><img src="png/use-1month.png" /></p>

    <?php exec ("./simpleuse.sh 1y $param --step 604800 $rightUnits"); ?>
    <h2>Previous year, by week</h2>
    <p><img src="png/use-1y.png" /></p>
   <form>
  </body>
</html>
