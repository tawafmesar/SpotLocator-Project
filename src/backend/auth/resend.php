<?php 

include "../connect.php"  ;

$email = filterRequest("email");

$verfiycode     = rand(10000 , 99999);

$data = array(
"users_verfiycode" => $verfiycode
) ; 

updateData("users" ,  $data  , "users_email = '$email'" ) ; 

sendEmail(
    $email, 
    "Dear User,

We are delighted to assist you through the SpotLocator App.

Your verification code to confirm your account is: $verfiycode

---

If you did not request this code, please disregard this email.

Best regards,  
[The SpotLocator App Team]",
    "Account Verification Code - SpotLocator App"
);