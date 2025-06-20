<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>PHP MySQL TEST</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>

<body>

<h2>DB接続テスト(PHP MySQL版)</h2>

<?php
  // エラーを出力する
  ini_set('display_errors', "On");
  ini_set('error_reporting', E_ALL & ~E_NOTICE);

  $hostname = "db";
  $username = "sample_user";
  $password = "pass";
  $dbname = "auth_test";
  $tbl = "test";

  $connect = mysqli_connect($hostname, $username, $password, $dbname);

  // データ表示
  $sql = "select * from $tbl";
  $sqlq = mysqli_query($connect,$sql);

  while($row = mysqli_fetch_array($sqlq)){
    echo $row["id"] . " / ";
    echo $row["name"] . " / ";
    echo $row["age"] . "<br>";
  }
  
  mysqli_free_result($sqlq);
  mysqli_close($connect);
?>

</body>
