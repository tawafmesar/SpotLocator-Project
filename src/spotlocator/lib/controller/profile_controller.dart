import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/class/statusrequest.dart';
import '../core/constant/routes.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';

abstract class ProfileScreenController extends GetxController {
  void logout();
}

class ProfileScreenControllerImp extends ProfileScreenController {
  int currentpage = 0;
  String? users_id;
  String? username;
  String? email;
  String? phone;
  String? users_create;

  late StatusRequest statusRequest;

  MyServices myServices = Get.find();

  @override
  void onInit() {
    users_id = myServices.sharedPreferences.getString("id");
    username = myServices.sharedPreferences.getString("username");
    email = myServices.sharedPreferences.getString("email");
    phone = myServices.sharedPreferences.getString("phone");
    users_create = myServices.sharedPreferences.getString("users_create");

    super.onInit();
  }

  @override
  void logout() async {
    myServices.sharedPreferences.setString("step", "1");
    await Future.delayed(Duration.zero);

    Get.offNamed(AppRoute.login);
  }
}
