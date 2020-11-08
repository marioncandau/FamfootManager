<?php
	// Connect to database
	include("db_connect.php");
	include("back.php");
	$request_method = $_SERVER["REQUEST_METHOD"];

	function getButs($id_buteuse)
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
                if(!empty($_GET["buteuse"]))
				{
					$id=$_GET["buteuse"];
					getBut($id);
                }
                break;
            case 'POST':
                addBut();
                break;
			default:
				// Invalid Request Method
				header("HTTP/1.0 405 Method Not Allowed");
				break;

		}
	}
?>