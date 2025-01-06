import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spotlocator/core/constant/imageasset.dart';
import '../../controller/vehicle_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../linkapi.dart';
import '../widget/add_vehicle_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehiclesControllerImp());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Vehicles',
        icon: Icons.directions_car,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.arrowsRotate, color: Colors.white),
            onPressed: () {
              controller.getVehiclesdata();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                GetBuilder<VehiclesControllerImp>(
                  builder: ((controller) => HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: SizedBox(
                      height: MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                      child: ListView.builder(
                        itemCount: controller.vehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = controller.vehicles[index];

                          final backgroundColor = index % 2 == 0
                              ? const Color(0xFF9CC5FF)
                              : const Color(0xFF80A4FF);

                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.horizontal,
                            confirmDismiss: (direction) async {
                              String action = direction == DismissDirection.startToEnd
                                  ? 'Activate'
                                  : 'Delete';

                              bool? confirm = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('$action Vehicle'),
                                    content: Text(
                                      direction == DismissDirection.startToEnd
                                          ? 'Are you sure you want to activate this vehicle?'
                                          : 'Are you sure you want to delete this vehicle?',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              return confirm;
                            },
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                controller.active(vehicle.vehicleId.toString());
                                Get.snackbar(
                                  "Vehicle Activated",
                                  "${vehicle.plateNumber} is now active.",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 2),
                                );
                              } else if (direction == DismissDirection.endToStart) {
                                controller.remove(vehicle.vehicleId.toString());
                                Get.snackbar(
                                  "Vehicle Deleted",
                                  "${vehicle.plateNumber} has been deleted.",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 2),
                                );
                              }
                            },
                            background: Container(
                              color: Colors.green,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.check_circle, color: Colors.white, size: 30),
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white, size: 30),
                            ),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                color: AppColor.backgroundcolor,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: backgroundColor,
                                      child: Image.asset(
                                        _getVehicleImage(vehicle.vehicleType),
                                        height: 140,
                                        width: 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 140,
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${vehicle.vehicleDesc}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "Plate : ${vehicle.plateNumber}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              "Car Type : ${vehicle.vehicleType}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(height: 2,),
                                            Center(
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: vehicle.vehicleStatus == 1 ? Colors.green : Colors.red,
                                                  borderRadius: BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 6,
                                                      offset: const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      vehicle.vehicleStatus == 1 ? Icons.check_circle : Icons.cancel,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 8), // Space between icon and text
                                                    Text(
                                                      vehicle.vehicleStatus == 1 ? 'Active' : 'Inactive',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddVehicleBottomSheet(context);
        },
        backgroundColor: AppColor.primaryColor,
        child: const Icon(
          Icons.add_circle_outline_sharp,
          color: Colors.white,
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
        return AppImageAsset.splash;
      case 'Sedan':
        return AppImageAsset.sedan;
      case 'Pickup':
        return AppImageAsset.pickup;
      default:
        return AppImageAsset.splash;
    }
  }
}
