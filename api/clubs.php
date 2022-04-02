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
		$query = "SELECT DISTINCT geocodage.club as club, geocodage.contact AS contact FROM geocodage INNER JOIN matchs ON matchs.equipe1_id = geocodage.contact WHERE matchs.competition = '".$compet."'";
		$response = [];
        $result = mysqli_query($conn, $query);
        while ($row = mysqli_fetch_assoc($result)) {
            $str = str_replace('&eacute;', '%C3%A9', $row);
            $str = str_replace('&agrave;', '%C3%A0', $str);
            $str = str_replace('&egrave;', '%C3%A8', $str);
            $response[] = $str;
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