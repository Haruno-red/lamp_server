<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>PHP MySQL TEST</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>

<body>

<h2>DB接続テスト(PHP MySQL版)</h2>

<?php
  $hostname = "localhost";
  $username = "ユーザ名";
  $password = "パスワード";
  $dbname = "データベース名";
  $tbl = "テーブル名";

  $connect = mysql_connect($hostname, $username, $password);
  mysql_select_db($dbname);

  // データ表示
  $sql = "select * from $tbl";
  $sqlq = mysql_query($sql, $connect);

  while($row = mysql_fetch_array($sqlq)){
    echo $row["row1"] . " / ";
    echo $row["row2"] . " / ";
    echo $row["row3"] . "<br>";
  }
  
  mysql_free_result($sqlq);
  mysql_close($connect);
?>

</body>

