<?php
	// Connect to database
	include("db_connect.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getCompetitions($date)
	{
		global $conn;
		$query = "SELECT DISTINCT competition FROM matchs WHERE date = '".$date."'";
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$str = str_replace('&eacute;', 'e', $row);
			$str = str_replace('&agrave;', 'a', $str);
			$str = str_replace('&egrave;', 'e', $str);
			$str = str_replace('/', '-', $str);
			$response[] = $str;
		}
		header('Content-Type: application/json');
		echo json_encode($response, JSON_PRETTY_PRINT);
	}
	
	switch($request_method)
	{
		
		case 'GET':
			// Retrieve Matchs
			if(!empty($_GET["date"]))
			{
				$date=$_GET["date"];
				getCompetitions($date);
			}
			break;
		default:
			// Invalid Request Method
			header("HTTP/1.0 405 Method Not Allowed");
			break;

	}
?>