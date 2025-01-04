<?php

include "../connect.php";

$email = filterRequest("email");

$verfiycode = rand(10000, 99999);

$stmt = $con->prepare("SELECT * FROM users WHERE users_email = ? ");
$stmt->execute(array($email));
$count = $stmt->rowCount();
result($count);

if ($count > 0) {
    $data = array("users_verfiycode" => $verfiycode);
    updateData("users", $data, "users_email = '$email'", false);
    sendEmail(
        $email, 
        "Dear User,
    
    We are here to help you reset your password for the SpotLocator App.
    
    Your verification code to reset your password is: $verfiycode
    
    ---
    
    Important Note:
    If you did not request a password reset, please disregard this email or contact our support team immediately.
    
    Best regards,  
    [The SpotLocator App Team]",
        "Password Reset Verification Code - SpotLocator App"
    );
    
    
}