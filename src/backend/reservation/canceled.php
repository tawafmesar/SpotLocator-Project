<?php


include "../connect.php";

$id = filterRequest("id");


$stmt = $con->prepare("SELECT * FROM parkingreservation WHERE reservation_id  = '$id' AND reservation_status = 0 ");

$stmt->execute();

$count = $stmt->rowCount();

if ($count > 0) {

    $data = array("reservation_status" => "2");

    updateData("parkingreservation", $data, "reservation_id = '$id'");
 
} else {
    printFailure("Parking Reservation not Correct or a status not panding");

}


?>