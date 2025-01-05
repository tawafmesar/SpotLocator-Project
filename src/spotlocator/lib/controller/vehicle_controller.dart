import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotlocator/data/models/vehicle_model.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';
import '../data/datasource/vehicles_data.dart';

abstract class VehiclesController extends GetxController {

}

class VehiclesControllerImp extends VehiclesController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController plate_number;
  late TextEditingController vehicle_desc;
  late TextEditingController vehicle_type;


  MyServices myServices = Get.find();


  bool showFormFields = false;

  void selectVehicleType(String type) {
    vehicle_type.text = type;
    showFormFields = true;
    update();
  }

  String? users_id;
  StatusRequest statusRequest = StatusRequest.none;

  VehiclesData vehiclesData = VehiclesData(Get.find());


  List vehicles = [];



  @override
  AddVehicle() async {
      print('plate_number.............. $plate_number');
      print('plate_number.............. $vehicle_desc');

      print('plate_number.............. $vehicle_type');
      print('plate_number.............. $users_id');

      if (formstate.currentState!.validate()) {
        statusRequest = StatusRequest.loading;
        update();
        try{
        var response = await vehiclesData.postdata(
            plate_number.text, vehicle_desc.text, vehicle_type.text, users_id!);
        print("=============================== Controller $response ");
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {

            _navigateTobackScreen(
              "Success",
              "The Metric has been added successfully.",
            );

            plate_number.clear();
            vehicle_desc.clear();
            vehicle_type.clear();

            await getVehiclesdata();

          } else {
            _navigateTobackScreen(
              "Notification",
              "Sorry, your Vehicle could not be added.",
            );
            statusRequest = StatusRequest.failure;

          }

        }

      } catch (e) {
    print("Error while adding Metric: $e");
    statusRequest = StatusRequest.serverfailure;
    }

        update();
      } else {
        Get.snackbar(
          "Error",
          "You must select a vehicle type.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
        );
        _navigateTobackScreen(
          "Notification",
          "Sorry, You must Enter Plate and description.",
        );

      }
      update();

  }



  @override
  void onInit() {
    plate_number = TextEditingController() ;
    vehicle_desc = TextEditingController();
    vehicle_type = TextEditingController();
    users_id = myServices.sharedPreferences.getString("id") ;
    getVehiclesdata();
    super.onInit();
  }

  @override
  void dispose() {
    plate_number.dispose();
    vehicle_desc.dispose();
    vehicle_type.dispose();
    super.dispose();
  }





  @override
  getVehiclesdata() async {
    vehicles.clear();
    statusRequest = StatusRequest.loading;
    var response = await vehiclesData.getdata(users_id!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {

        // Assuming response['data'] is a List of Map<String, dynamic>
        vehicles.addAll(response['data'].map((e) => vehicle_model.fromJson(e)).toList());
        print(vehicles);


      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> _navigateTobackScreen(String title, String middleText) async {
    Get.defaultDialog(
      title: title,
      middleText:  middleText,
    );

    await Future.delayed(Duration(seconds: 3));

    Get.back();
    Get.back();

  }

}