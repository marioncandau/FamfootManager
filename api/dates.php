<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getDates()
	{
		global $conn;
		$query = "SELECT DISTINCT date FROM matchs";
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = $row;
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
				getDates();
				break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
	else {
		header("HTTP/1.0 401 Unauthorized");
	}
?>