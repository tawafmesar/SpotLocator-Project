import 'package:spotlocator/data/datasource/reservation_data.dart';
import 'package:spotlocator/data/models/reservation_model.dart';
import 'package:get/get.dart';
import '../core/class/statusrequest.dart';
import '../core/functions/handingdatacontroller.dart';
import '../core/services/services.dart';

abstract class ReservationController extends GetxController {}

class ReservationControllerImp extends ReservationController {
  MyServices myServices = Get.find();

  String? users_id;
  StatusRequest statusRequest = StatusRequest.none;

  ReservationData reservationData = ReservationData(Get.find());

  List Reservation = [];

  List<reservation_model> data = [];

  @override
  void onInit() {
    users_id = myServices.sharedPreferences.getString("id");
    getReservationData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  getReservationData() async {
    data.clear();
    statusRequest = StatusRequest.loading;
    var response = await reservationData.getdata(users_id!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data = (response['data'] as List<dynamic>)
            .map((e) => reservation_model.fromJson(e as Map<String, dynamic>))
            .toList();
        print(data);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> _navigateTobackScreen(String title, String middleText) async {
    Get.defaultDialog(
      title: title,
      middleText: middleText,
    );

    await Future.delayed(Duration(seconds: 3));

    Get.back();
    Get.back();
  }

  @override
  cancel(String id) async {
    print("=============================== id $id ");
    print(id);
    statusRequest = StatusRequest.loading;
    var response = await reservationData.canceldata(id);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        _navigateTobackScreen(
            "Success", "The Reservation was canceled successfully");
        await getReservationData();
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
