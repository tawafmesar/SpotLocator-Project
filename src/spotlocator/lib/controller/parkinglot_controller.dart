
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/statusrequest.dart';
import '../core/constant/parkinglot.dart';
import '../core/constant/routes.dart';
import '../core/functions/handingdatacontroller.dart';

import '../core/services/services.dart';

import '../data/datasource/parkinglot_data.dart';
import '../data/datasource/vehicles_data.dart';
import '../data/models/parkingspot_model.dart';
import '../linkapi.dart';

abstract class ParkingLotController extends GetxController {

}

class ParkingLotControllerImp extends ParkingLotController {

  MyServices myServices = Get.find();

  String? users_id;
  String? vehicleIds;
  bool activitreservation =true;
  String allReservationCount = '0';

  String? allReservationCountshared;

  StatusRequest statusRequest = StatusRequest.none;

  ParkingLotData parkingLotData = ParkingLotData(Get.find());

  List<parkingspot_model> data = [];

   List reservationvehicle = [];

  late TextEditingController vehicle_id;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<String> vehiclesdata = [];

  Map<String, String> vehivleseMap = {};
  VehiclesData vehiclesData = VehiclesData(Get.find());



  @override
  void onInit() {
    users_id = myServices.sharedPreferences.getString("id") ;
    vehicleIds = myServices.sharedPreferences.getString("vehicleIds") ;
    vehicle_id = TextEditingController();

    getVehiclesdata();
    getparkinglot();
    super.onInit();

    // print("placesid ...................................");
    // print(placesid);

    updatedata();

    if (myServices.sharedPreferences.getString("allReservationCount") == null) {
      allReservationCountshared = "";
    } else {
      allReservationCountshared = myServices.sharedPreferences.getString("allReservationCount")!;
    }


    print('Count of allReservationCountshared = 0: $allReservationCountshared');

  }


  updatedata(){

    updateshaerd( 'allReservationCount' ,  '');
    update();

  }

  @override
  void dispose() {
    vehicle_id.dispose();

    super.dispose();
  }


  @override
  getparkinglot() async {
    parkinglot.clear();
    statusRequest = StatusRequest.loading;
    var response = await parkingLotData.getdata();
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {

        data.addAll(response['data'].map<parkingspot_model>((e) => parkingspot_model.fromJson(e)).toList());



      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }


  gotoaddvehicle(){

    Get.toNamed(AppRoute.addvehicleScreen);

  }


  @override
  addreservation(String parkingid) async {
    if (vehicleIds != null) {
      print("=============================== parkingid  ");

      print(parkingid);
      print("=============================== vehicleIds  ");
      print(vehicleIds);

      print(vehicleIds.runtimeType);
      statusRequest = StatusRequest.loading;


      update();
      var response = await parkingLotData.addreservationdata(vehicle_id.text, parkingid);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          getparkinglot();
          _navigateToback2Screen();
          update();
        } else {
          //          Get.defaultDialog(title: "Error", middleText: " ");
          getparkinglot();

          _navigateTobackScreen('Error','This vehicle have previous  reservation ');
          //statusRequest = StatusRequest.failure;
          update();

        }
      }
      update();
    } else {
      print("Error: vehicleIds is null");
    }
  }



  @override
  getVehiclesdata() async {
    vehiclesdata.clear();
    statusRequest = StatusRequest.loading;
    var response = await vehiclesData.getdata(users_id!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {




        List<dynamic> responsedata = response['data'];
        for (var item in responsedata) {
          String vehicleId = item['vehicle_id'].toString();
          String vehicleName = item['plate_number'];
          vehiclesdata.add(vehicleName);
          vehivleseMap[vehicleName] = vehicleId;
        }
        print("vehiclesdata......................................");
        print(vehiclesdata);

        print("vehivleseMap......................................");
        print(vehivleseMap);

      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }




  Future<void> _navigateTobackScreen(String title, String middletext ) async {
    Get.defaultDialog(
      title: title,
      middleText: middletext ,
    );

    await Future.delayed(Duration(seconds: 3));

    Get.back();

  }

  Future<void> _navigateToback2Screen() async {
    Get.defaultDialog(
      title: "Success",
      middleText: "The reservation was added successfully",
    );

    await Future.delayed(Duration(seconds: 2));

    Get.back();
    Get.back();

  }

  updateshaerd(String Kay , String Value){
    myServices.sharedPreferences
        .setString(Kay, Value);
    

  }


  buttumupdate()  {
    getVehiclesdata();
    getparkinglot();
    update();
  }




}