<?php 
    include("db_connect.php");

    function verify_APIKey($apikey) {
        global $conn;
		$query = "SELECT apikey FROM fam__apiauth LIMIT 1";
		$response = array();
		$result = mysqli_query($conn, $query);
		while($row = mysqli_fetch_assoc($result))
		{
			if($row['apikey'] == $apikey) {
                return True;
            }
            else {
                return False;
            }
        }
        return False;
    }
?>