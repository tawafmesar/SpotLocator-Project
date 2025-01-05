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
    Get.put(VehiclesControllerImp());
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

                          return Card(
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
                                    color: backgroundColor ,
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
                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Plate : ${vehicle.plateNumber}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Car Type : ${vehicle.vehicleType}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "Status: ${vehicle.vehicleStatus == 1 ? 'Active' : 'Inactive'}",
                                            style: TextStyle(
                                              color: vehicle.vehicleStatus == 1
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      ,
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
        child: const Icon(Icons.add_circle_outline_sharp,color: Colors.white,),
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
