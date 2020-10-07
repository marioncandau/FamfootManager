<?php
	// Connect to database
	include("db_connect.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getMatch($id=0)
	{
		global $conn;
		$query = "SELECT * FROM matchs";
		if($id != 0)
		{
			$query .= " WHERE id=".$id." LIMIT 1";
		}
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = $row;
		}
		header('Content-Type: application/json');
		echo json_encode($response, JSON_PRETTY_PRINT);
	}
	
	function getMatchFromDate($date='')
	{
		global $conn;
		$query = "SELECT * FROM matchs";
		if($date != '')
		{
			$query .= " WHERE date='".$date."'";
		}
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = $row;
		}
		header('Content-Type: application/json');
		echo json_encode($response, JSON_PRETTY_PRINT);
	}

	function getMatchFromDateAndCompet($date='', $compet='')
	{
		global $conn;
		$query = "SELECT * FROM matchs";
		if($date != '')
		{
			$query .= " WHERE date='".$date."'";
		}
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$str = str_replace('&eacute;', 'e', $row['competition']);
			$str = str_replace('&agrave;', 'a', $str);
			$str = str_replace('&egrave;', 'e', $str);
			$str = str_replace('/', '-', $str);
			if($compet == $str) {
				$response[] = $row;
			}
		}
		header('Content-Type: application/json');
		echo json_encode($response, JSON_PRETTY_PRINT);
	}
	
	function updateMatch($id)
	{
		global $conn;
		$_PUT = array();
		parse_str(file_get_contents('php://input'), $_PUT);
		$forfait1 = intval($_PUT["forfait1"]);
		$forfait2 = intval($_PUT["forfait2"]);
		$buteuses1 = $_PUT["buteuses1"];
		$buteuses2 = $_PUT["buteuses2"];
		$score = $_PUT["score"];
		$query="UPDATE matchs SET forfait1=".$forfait1.", forfait2=".$forfait2.", buteuses1='".$buteuses1."', buteuses2='".$buteuses2."', score='".$score."' WHERE id=".$id;
		
		if(mysqli_query($conn, $query))
		{
			$response=array(
				'status' => 1,
				'status_message' =>'match mis a jour avec succes.'
			);
		}
		else
		{
			$response=array(
				'status' => 0,
				'status_message' =>'Echec de la mise a jour de match. '. mysqli_error($conn)
			);
			
		}
		
		header('Content-Type: application/json');
		echo json_encode($response);
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
				if(!empty($_GET["id"]))
				{
					$id=intval($_GET["id"]);
					getMatch($id);
				}
				else if(!empty($_GET["date"]) and empty($_GET["compet"]))
				{
					$date=$_GET["date"];
					getMatchFromDate($date);
				}
				else if(!empty($_GET["date"]) and !empty($_GET["compet"]))
				{
					$date=$_GET["date"];
					$compet=$_GET["compet"];
					getMatchFromDateAndCompet($date, $compet);
				}
				break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;
				
			case 'PUT':
				// Modifier un produit
				$id = intval($_GET["id"]);
				updateMatch($id);
				break;

		}
	}
?>