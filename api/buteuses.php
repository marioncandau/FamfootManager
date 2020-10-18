<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getButeuses($club)
	{
		global $conn;
		$query = "SELECT DISTINCT * FROM fam__buteuses WHERE club = ".$club;
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = array_map("utf8_encode", $row);
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }
    
    function addButeuse()
	{
		global $conn;
		// $_PUT = array();
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
            }
            else
            {
                $response=array(
                    'status' => 0,
                    'status_message' =>'Echec de l ajout de buteuse. '. mysqli_error($conn)
                );
                
            }
            
            header('Content-Type: application/json');
            echo json_encode($response);
        }
        else {
            $response = isset_error('POST');
        }
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
					getButeuses($club);
                }
                else if(!empty($_GET["id"]))
				{
					$id=$_GET["id"];
					getButeuse($id);
				}
                break;
            case 'POST':
                addButeuse();
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
?>