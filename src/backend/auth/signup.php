<?php

include "../connect.php";

$username = filterRequest("username");
$password = sha1($_POST['password']);
$email = filterRequest("email");
$phone = filterRequest("phone");
$verfiycode     = rand(10000 , 99999);


$stmt = $con->prepare("SELECT * FROM users WHERE users_email = ? OR users_phone = ? ");
$stmt->execute(array($email, $phone));
$count = $stmt->rowCount();
if ($count > 0) {
    printFailure("PHONE OR EMAIL");
} else {

    $data = array(
        "users_name" => $username,
        "users_password" =>  $password,
        "users_email" => $email,
        "users_phone" => $phone,
        "users_verfiycode" => $verfiycode ,
        "users_role" => 1 ,

    );
    sendEmail(
        $email, 
        "Dear User,
    
    We are delighted to assist you through the Awonhm App.
    
    Your verification code to confirm your account is: $verfiycode
    
    ---
    
    If you did not request this code, please disregard this email.
    
    Best regards,  
    [The SpotLocator App Team]",
        "Account Verification Code - SpotLocator App"
    );
        insertData("users" , $data) ; 

}