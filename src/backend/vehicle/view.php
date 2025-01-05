<?php


include "../connect.php";


$id = filterRequest("id");


getAllData("vehicles", "vehicle_userid  = ?  ", array($id));

