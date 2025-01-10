<?php


include "../connect.php";


$user_id = filterRequest("user_id");

$stmt = $con->prepare("SELECT 
    pr.reservation_id,
    pr.reservation_date,
    pr.reservation_status,
    ps.spot_name AS parking_spot_name,
    ps.latitude,
    ps.longitude,
    d.dept_name AS department_name,
    d.dept_short AS department_short,
    d.dept_image AS department_image,
    v.plate_number AS vehicle_plate,
    v.vehicle_desc AS vehicle_desc,
    v.vehicle_type,
    v.vehicle_status,
    u.users_id ,
    u.users_name,
    u.users_email,
    u.users_phone
FROM 
    parkingreservation pr
JOIN 
    parkingspot ps ON pr.parkingspot_id = ps.parkingspot_id
JOIN 
    department d ON ps.dept_id = d.dept_id
JOIN 
    vehicles v ON pr.vehicle_id = v.vehicle_id
JOIN 
    users u ON v.vehicle_userid = u.users_id
WHERE u.users_id = :user_id ");

$stmt->execute(array(':user_id' => $user_id));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "failure"));
}
