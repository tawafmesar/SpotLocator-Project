class AppLink {

  static const String server = "http://10.0.2.2/app/SpotLocator-Project/src/backend/";

  static const String test = "$server/test.php";
  static const String imagesstatic = "$server/upload" ;


  static const String viewcategories = "$server/categories.php";

  static const String imagestCategories = "$imagesstatic/categories" ;
// ================================= Auth ========================== //


  static const String signUp = "$server/auth/signup.php";
  static const String login = "$server/auth/login.php";
  static const String resend = "$server/auth/resend.php";

  static const String verifycodessignup = "$server/auth/verfiycode.php";

// ================================= ForgetPassword ========================== //

  static const String checkEmail = "$server/forgetpassword/checkemail.php";
  static const String resetPassword = "$server/forgetpassword/resetpassword.php";
  static const String verifycodeforgetpassword = "$server/forgetpassword/verifycode.php";



// ================================= Vehicle ========================== //

  static const String vehicleview = "$server/vehicle/view.php"  ;









}
