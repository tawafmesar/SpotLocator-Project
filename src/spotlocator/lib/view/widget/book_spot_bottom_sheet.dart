import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controller/parkinglot_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../widget/auth/custombuttonauth.dart';
import 'custom_elevated_button.dart';

void showBottomSheetBoxSpot(BuildContext context, String parkigid) {
  String? parkig_id = parkigid;

  Get.bottomSheet(
    backgroundColor: const Color(0xffEAF8FB),
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GetBuilder<ParkingLotControllerImp>(
        builder: (controller) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reserve Parking Spot',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 2, color: AppColor.primaryColor),
                  const SizedBox(height: 10),

                  // Vehicle Selection
                  const Text(
                    "Select a Vehicle",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.vehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = controller.vehicles[index];
                        return _buildVehicleCard(controller, vehicle, context);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child:
                    CustomElevatedButton(
                      text: "Reserve Spot",
                      icon: Icons.directions_car,
                      onPressed: () {
                        if (controller.vehicle_id.text.isEmpty) {
                          Get.snackbar(
                            "Error",
                            "Please select a vehicle to reserve the spot.",
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 3),
                          );
                        } else {
                          controller.addreservation(parkig_id );
                        }
                      },
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    isScrollControlled: true,
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(42),
        topRight: Radius.circular(42),
      ),
    ),
  );
}

Widget _buildVehicleCard(ParkingLotControllerImp controller, vehicle, BuildContext context) {
  return GestureDetector(
    onTap: () {
      controller.vehicle_id.text = vehicle.vehicleId.toString();
      controller.update();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 115,
      decoration: BoxDecoration(
        color: controller.vehicle_id.text == vehicle.vehicleId.toString()
            ? AppColor.primaryColor.withOpacity(0.2)
            : AppColor.backgroundcolor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: controller.vehicle_id.text == vehicle.vehicleId.toString()
              ? AppColor.primaryColor
              : Colors.grey,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _getVehicleImage(vehicle.vehicleType),
            width: 73,
            height: 73,
            fit: BoxFit.cover,
          ),
          Text(
            vehicle.plateNumber ?? 'Unknown',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            vehicle.vehicleDesc ?? '',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
  );
}

String _getVehicleImage(String? type) {
  switch (type) {
    case 'SUV':
      return AppImageAsset.suv;
    case 'Electric':
      return AppImageAsset.electric;
    case 'Hatchback':
      return AppImageAsset.hatchback;
    case 'Sedan':
      return AppImageAsset.sedan;
    case 'Pickup':
      return AppImageAsset.pickup;
    default:
      return AppImageAsset.splash;
  }
}
