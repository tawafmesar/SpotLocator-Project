<?php 

include "../connect.php";

$vehicle_id = filterRequest("vehicle_id");
$parkingspot_id  = filterRequest("parkingspot_id");

// Check if the vehicle exists in the database
$stmt = $con->prepare("SELECT * FROM parkingreservation WHERE vehicle_id = ? AND reservation_status = 0");
$stmt->execute([$vehicle_id]);

$count = $stmt->rowCount();

if ($count > 0) {
    // If the vehicle has a previous reservation
    printFailure("This vehicle has a previous reservation");
} else {
    // Check if the vehicle exists at all
    $checkVehicle = $con->prepare("SELECT * FROM vehicles WHERE vehicle_id = ?");
    $checkVehicle->execute([$vehicle_id]);

    if ($checkVehicle->rowCount() == 0) {
        // If the vehicle doesn't exist
        printFailure("This vehicle doesn't exist");
    } else {
        // Proceed with the reservation
        $data = array(
            "vehicle_id" => $vehicle_id,
            "parkingspot_id" => $parkingspot_id,
        );

        insertData("parkingreservation", $data);

        $data2 = array("spot_status" => "1");
        updateData("parkingspot", $data2, "parkingspot_id = '$parkingspot_id'", false);
    }
}
?>
