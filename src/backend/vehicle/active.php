<?php


include "../connect.php";


$id = filterRequest("id");

$user_id = filterRequest("user_id");



$stmt = $con->prepare(" UPDATE vehicles SET vehicle_status = 0  WHERE vehicle_userid = '$user_id'");

$stmt->execute();

$count = $stmt->rowCount();

if ($count > 0) {

    $data = array("vehicle_status" => "1");

    updateData("vehicles", $data, "vehicle_id  = '$id'");
 
} else {
    printFailure("Vehicle not Correct");

}
