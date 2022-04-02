<?php 
    include("db_connect.php");
    mb_internal_encoding('UTF-8');
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

    function ifisset($table, $post) {
        for($i = 0; $i < count($table); $i++) {
            if(isset($post[$table[$i]]) == false) {
                return false;
            }
        }
        return true;
    }

    function isset_error($value) {
        return array(
            'status' => 0,
            'status_message' =>'Bad '.$value.' request'
        );
    
    }
?>