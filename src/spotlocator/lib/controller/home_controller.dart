import 'package:get/get.dart';
import '../core/constant/routes.dart';
import '../core/services/services.dart';

class HomeController extends GetxController {
  var currentTabIndex = 0.obs;
  MyServices myServices = Get.find();

  void changeTabIndex(int index) {
    currentTabIndex.value = index;
  }

  @override
  logout() async {
    myServices.sharedPreferences.setString("step", "1");
    await Future.delayed(Duration.zero);
    Get.offNamed(AppRoute.login);
  }
}
