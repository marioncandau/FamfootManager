<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getButeuses()
	{
		global $conn;
		$query = "SELECT DISTINCT nom FROM fam__buteuses";
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

	function getButeusesFromClub($club)
	{
		global $conn;
		$query = "SELECT * FROM fam__buteuses WHERE club = ".$club;
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = $row;
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
	}
	
	function getButeusesFromCompet($compet)
	{
		global $conn;
		$query = "SELECT * FROM fam__buteuses WHERE championnat = '".$compet."'";
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = $row;
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }
    
    function addButeuse()
	{
		global $conn;
		// $_PUT = array();
		$_POST = json_decode(file_get_contents('php://input'), true);
		if(ifisset(['club', 'nom', 'championnat'], $_POST)) {
            $club = intval($_POST["club"]);
            $championnat = mysqli_real_escape_string($conn,htmlspecialchars($_POST["championnat"]));
            $nom = mysqli_real_escape_string($conn,htmlspecialchars($_POST["nom"]));
            $query="INSERT INTO fam__buteuses(nom, club, championnat) VALUES ('".$nom."', ".$club.", '".$championnat."');";
            
            if(mysqli_query($conn, $query))
            {
                $q2 = "SELECT id FROM fam__buteuses WHERE nom = '".$nom."'";
                $r2 = mysqli_query($conn, $q2);
                $row2 = mysqli_fetch_assoc($r2);
                $response=array(
                    'status' => 1,
                    'id' => $row2['id'],
                    'status_message' =>'buteuse ajoutee'
				);
            }
            else
            {
                $response=array(
                    'status' => 0,
                    'status_message' =>'Echec de l ajout de buteuse. '. mysqli_error($conn)
                );
                
            }
        }
        else {
            $response = isset_error('POST');
		}
		header('Content-Type: application/json');
        echo json_encode($response);
	}

	function editButeuse($id)
	{
		global $conn;
		// $_PUT = array();
		$_PUT = json_decode(file_get_contents('php://input'), true);
		if(ifisset(['club', 'nom'], $_PUT)) {
            $club = intval($_PUT["club"]);
            $nom = mysqli_real_escape_string($conn,htmlspecialchars($_PUT["nom"]));
            $query="UPDATE fam__buteuses SET nom = '".$nom."', club = ".$club." WHERE id = ".$id;
            
            if(mysqli_query($conn, $query))
            {
                $q2 = "SELECT id FROM fam__buteuses WHERE nom = '".$nom."'";
                $r2 = mysqli_query($conn, $q2);
                $row2 = mysqli_fetch_assoc($r2);
                $response=array(
                    'status' => 1,
                    'id' => $row2['id'],
                    'status_message' =>'buteuse modifiee'
				);
            }
            else
            {
                $response=array(
                    'status' => 0,
                    'status_message' =>'Echec de la modification de buteuse. '. mysqli_error($conn)
                );
                
            }
        }
        else {
            $response = isset_error('PUT');
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
				if(!empty($_GET["club"]))
				{
					$club=$_GET["club"];
					getButeusesFromClub($club);
				}
				else if(!empty($_GET["compet"]))
				{
					$compet=$_GET["compet"];
					getButeusesFromCompet($compet);
                }
                else if(!empty($_GET["id"]))
				{
					$id=$_GET["id"];
					getButeuse($id);
				}
				else {
					getButeuses();
				}
                break;
			case 'POST':
				addButeuse();
				break;
			case 'PUT':
				if(!empty($_GET["id"]))
				{
					$id=$_GET["id"];
					editButeuse($id);
				}
				break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
?>