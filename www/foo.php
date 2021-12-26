<?php
$db = new PDO('mysql:host=localhost;dbname=testdb;port=3306;charset=utf8mb4', 'root', 'root');

$sql = 'SELECT orderid FROM orders ORDER BY orderid';
foreach ($db->query($sql) as $row) {
    print $row['orderid'] . "\n";
}
