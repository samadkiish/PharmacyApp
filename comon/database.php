<?php
include "constant.php";
session_start();

// Create connection
$conn = new mysqli(SERVER_NAME,USERNAME,PASSWORD,DATABASE);


// Check connection
if ($conn->connect_error) {
 die("Connection failed: " . $conn->connect_error);
} 
//echo "Connected successfully";
?>
