<?php 

include "../connect.php" ; 

$id = filterRequest("id") ; 

deleteData("vehicles" , "vehicle_id  = $id") ; 
