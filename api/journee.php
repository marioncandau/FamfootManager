<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getJournee($compet)
	{
		global $conn;
		$compet = str_replace('é', '&eacute;', $compet);
		$compet = str_replace('à', '&agrave;', $compet);
		$compet = str_replace('è', '&egrave;', $compet);
		$query = "SELECT DISTINCT journee FROM matchs WHERE competition = '".$compet."'";
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = intval($row['journee']);
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
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
				if(!empty($_GET["compet"]))
				{
					$compet=$_GET["compet"];
					getJournee($compet);
				}
				break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
?>