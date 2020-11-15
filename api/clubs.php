<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getClubs($compet)
	{
		global $conn;
		$compet = str_replace('é', '&eacute;', $compet);
		$compet = str_replace('à', '&agrave;', $compet);
		$compet = str_replace('è', '&egrave;', $compet);
		$query = "SELECT DISTINCT equipe1_id FROM matchs WHERE competition = '".$compet."'";
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$q2 = "SELECT club, contact FROM geocodage WHERE contact = ".$row['equipe1_id']." and 1";
			$r2 = mysqli_query($conn, $q2);
			$row2 = mysqli_fetch_assoc($r2);
			$row2 = array_map("utf8_encode", $row2);
			$response[] = str_replace('\\', '', $row2);
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
	}

	function getClubFromButeuse($buteuse)
	{
		global $conn;
		$query = "SELECT club FROM fam__buteuses WHERE id = ".$buteuse;
		$result = mysqli_query($conn, $query);
		$row = mysqli_fetch_assoc($result);
		$response = $row;
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
					getClubs($compet);
				}
				else if(!empty($_GET["buteuse"]))
				{
					$buteuse=$_GET["buteuse"];
					getClubFromButeuse($buteuse);
				} 
				break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
?>