import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handingdatacontroller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth/login.dart';
abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }
  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          var usersApprove = response['data']['users_approve'];
          // Print the type for debugging
          print('users_approve type: ${usersApprove.runtimeType}');

          if (usersApprove == 1 || usersApprove == "1") {
            myServices.sharedPreferences
                .setString("id", response['data']['users_id'].toString());
            myServices.sharedPreferences
                .setString("username", response['data']['users_name'].toString());
            myServices.sharedPreferences
                .setString("email", response['data']['users_email'].toString());
            myServices.sharedPreferences
                .setString("phone", response['data']['users_phone'].toString());
            myServices.sharedPreferences
                .setString("users_avatar", response['data']['users_avatar'].toString());
            myServices.sharedPreferences
                .setString("users_create", response['data']['users_create'].toString());
            myServices.sharedPreferences
                .setString("users_role", response['data']['users_role'].toString());
            myServices.sharedPreferences.setString("step", "2");
            Get.offNamed(AppRoute.home);
          } else {
            Get.toNamed(AppRoute.verfiyCodeSignUp,
                arguments: {"email": email.text});
          }
        } else {
          Get.defaultDialog(
              title: "Alert", middleText: "The email or password is incorrect");
          statusRequest = StatusRequest.failure;
        }
      }


    update();
    } else {}
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {

    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}