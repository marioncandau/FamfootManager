<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getButsFromButeuse($id_buteuse)
	{
		global $conn;
		$query = "SELECT * FROM fam__buts WHERE buteuse = ".$id_buteuse;
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = array_map("utf8_encode", $row);
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
	}
	
	function getBut($id)
	{
		global $conn;
		$query = "SELECT * FROM fam__buts WHERE id = ".$id;
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = array_map("utf8_encode", $row);
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
	}
	
	function getButFromButeuseAndJournee($buteuse, $journee)
	{
		global $conn;
		$query = "SELECT * FROM fam__buts WHERE buteuse = ".$buteuse." and journee = ".$journee;
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			$response[] = array_map("utf8_encode", $row);
		}
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($response, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
    }
    
    function addBut()
	{
		global $conn;
        // $_PUT = array();
        $_POST = json_decode(file_get_contents('php://input'), true);
		if(ifisset(['buteuse', 'journee', 'nbButs'], $_POST)) {
            $buteuse = intval($_POST["buteuse"]);
            $journee = intval($_POST["journee"]);
            $nbbuts = intval($_POST["nbButs"]);
            $query="INSERT INTO fam__buts(buteuse, journee, nbButs) VALUES (".$buteuse.", ".$journee.", ".$nbbuts.");";
            
            if(mysqli_query($conn, $query))
            {
                $response=array(
                    'status' => 1,
                    'status_message' =>'but ajoute'
				);
            }
            else
            {
                $response=array(
                    'status' => 0,
                    'status_message' =>'Echec de l ajout de but. '. mysqli_error($conn)
                );
                
            }
            
            header('Content-Type: application/json');
            echo json_encode($response);
        }
        else {
            $response = isset_error('POST');
        }
	}

	function editBut($id)
	{
		global $conn;
        // $_PUT = array();
        $_PUT = json_decode(file_get_contents('php://input'), true);
		if(ifisset(['nbButs'], $_PUT)) {
            $nbbuts = intval($_PUT["nbButs"]);
            $query="UPDATE fam__buts SET nbButs = ".$nbbuts." WHERE id = ".$id.";";
            
            if(mysqli_query($conn, $query))
            {
                $response=array(
                    'status' => 1,
                    'status_message' =>'but modifie'
				);
            }
            else
            {
                $response=array(
                    'status' => 0,
                    'status_message' =>'Echec de la modification de but. '. mysqli_error($conn)
                );
                
            }
            
            header('Content-Type: application/json');
            echo json_encode($response);
        }
        else {
            $response = isset_error('PUT');
        }
	}

	function deleteBut($id)
	{
		global $conn;
		$query="DELETE FROM fam__buts WHERE id = ".$id;
		
		if(mysqli_query($conn, $query))
		{
			$response=array(
				'status' => 1,
				'status_message' =>'but supprime'
			);
		}
		else
		{
			$response=array(
				'status' => 0,
				'status_message' =>'Echec de la suppression de but. '. mysqli_error($conn)
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
				// Retrieve But
				if(!empty($_GET["buteuse"]) and !empty($_GET["journee"]))
				{
					$buteuse=intval($_GET["buteuse"]);
					$journee=intval($_GET["journee"]);
					getButFromButeuseAndJournee($buteuse, $journee);
				}
                else if(!empty($_GET["buteuse"]))
				{
					$id=intval($_GET["buteuse"]);
					getButsFromButeuse($id);
				}
				else if(!empty($_GET["id"]))
				{
					$id=intval($_GET["id"]);
					getBut($id);
				}
                break;
            case 'POST':
                addBut();
				break;
			case 'PUT':
				if(!empty($_GET["id"])) {
					$id = intval($_GET['id']);
					editBut($id);
				}
				break;
			case 'DELETE':
				if(!empty($_GET["id"])) {
					$id = intval($_GET['id']);
					deleteBut($id);
				}
				break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
?>