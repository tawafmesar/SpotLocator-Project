<?php

include "../connect.php";

$plate_number = filterRequest("plate_number");
$vehicle_desc = filterRequest("vehicle_desc");
$vehicle_type = filterRequest("vehicle_type");
$vehicle_userid  = filterRequest("vehicle_userid");


$stmt = $con->prepare("SELECT * FROM vehicles WHERE vehicle_userid  = ?  ");
$stmt->execute(array($vehicle_userid));

$count = $stmt->rowCount();
if ($count > 0) {
    $data = array(
        "plate_number" => $plate_number,
        "vehicle_desc" =>  $vehicle_desc,
        "vehicle_type" => $vehicle_type,
        "vehicle_userid" => $vehicle_userid,
        "vehicle_status" => 0,

    );
    insertData("vehicles" , $data) ; 

} else {
    $data = array(
        "plate_number" => $plate_number,
        "vehicle_desc" =>  $vehicle_desc,
        "vehicle_type" => $vehicle_type,
        "vehicle_userid" => $vehicle_userid,
        "vehicle_status" => 1,

    );
    insertData("vehicles" , $data) ; 


}

