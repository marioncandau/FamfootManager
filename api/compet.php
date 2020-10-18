<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getCompetitionsFromDate($date)
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

	function getCompetitionsButeuses()
	{
		global $conn;
		$query = "SELECT DISTINCT competition FROM matchs WHERE compet_slug = 'r1' or compet_slug = 'r2'";
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$str = str_replace('&eacute;', '%C3%A9', $row);
			$str = str_replace('&agrave;', '%C3%A0', $str);
			$str = str_replace('&egrave;', '%C3%A8', $str);
			$response[] = $str;
		}
		header('Content-Type: application/json');
		echo json_encode($response, JSON_PRETTY_PRINT);
	}

	$auth = apache_request_headers();
	foreach ($auth as $header => $value)
	{
		if ($header == "Api") {
			$auth = $value;
		}
	}

	if(verify_APIKey($auth)) {
	
		switch($request_method)
		{
			
			case 'GET':
				// Retrieve Matchs
				if(!empty($_GET["date"]))
				{
					$date=$_GET["date"];
					getCompetitionsFromDate($date);
				}
				else {
					getCompetitionsButeuses();
				}
				break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
?>