<?php


include "./connect.php";



//getAllData("parkinglot", "parkinglot_status != 1");


function getAvailableParkingLots($json = true)
{
    global $con;
    $data = array();
    
    // The SQL query to get available parking lots
    $sql = "SELECT ps.*, d.dept_name, d.dept_short, d.dept_image
FROM parkingspot ps
LEFT JOIN department d
ON ps.dept_id = d.dept_id
LEFT JOIN parkingreservation r
ON ps.parkingspot_id = r.parkingspot_id
WHERE r.parkingspot_id IS NULL;
";

    // Prepare and execute the statement
    $stmt = $con->prepare($sql);
    $stmt->execute();
    
    // Fetch all results
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $count = $stmt->rowCount();
    
    if ($json == true) {
        if ($count > 0) {
            echo json_encode(array("status" => "success", "data" => $data));
        } else {
            echo json_encode(array("status" => "failure"));
        }
        return $count;
    } else {
        if ($count > 0) {
            return $data;
        } else {
            return json_encode(array("status" => "failure"));
        }
    }
}

getAvailableParkingLots();