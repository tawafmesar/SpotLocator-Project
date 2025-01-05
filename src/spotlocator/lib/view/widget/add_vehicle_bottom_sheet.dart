import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import '../../controller/vehicle_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../../core/functions/validinput.dart';
import '../widget/auth/customtextformauth.dart';

void AddVehicleBottomSheet(BuildContext context) {
  Get.bottomSheet(
    backgroundColor: Color(0xffEAF8FB),
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GetBuilder<VehiclesControllerImp>(
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
                        'Add Vehicle',
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
                  const SizedBox(height: 10,),
                  Divider(height: 2,color: AppColor.primaryColor,),
                  const SizedBox(height: 10),

                  const Text(
                    "Select Vehicle Type",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildVehicleTypeCard(controller, "Electric", AppImageAsset.electric),
                        _buildVehicleTypeCard(controller, "Pickup", AppImageAsset.pickup),
                        _buildVehicleTypeCard(controller, "SUV", AppImageAsset.suv),
                        _buildVehicleTypeCard(controller, "Hatchback", AppImageAsset.hatchback),
                        _buildVehicleTypeCard(controller, "Sedan", AppImageAsset.sedan),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  CustonTextFormAuth(
                    isNumber: false,
                    valid: (val) => validInput(val!, 3, 20, "plate_number"),
                    mycontroller: controller.plate_number,
                    hinttext: "Enter vehicle plate",
                    iconData: FontAwesome.cab,
                    labeltext: "Plate",
                  ),
                  const SizedBox(height: 10),
                  CustonTextFormAuth(
                    isNumber: false,
                    valid: (val) => validInput(val!, 3, 35, "vehicle_desc"),
                    mycontroller: controller.vehicle_desc,
                    hinttext: "Enter vehicle description",
                    iconData: Icons.description,
                    labeltext: "Description",
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.4, 0.8],
                          colors: [
                            Color(0xFF008FFF),
                            Color(0xFF0062CA),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.vehicle_type.text.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "You must select a vehicle type.",
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(10),
                              duration: const Duration(seconds: 3),
                            );
                          } else {
                            controller.AddVehicle();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 8,
                          backgroundColor: Colors.transparent, // Make button background transparent
                          shadowColor: Colors.transparent, // Remove shadow to show gradient clearly
                        ),
                        child: const Text(
                          "Add Vehicle",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    ,
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

Widget _buildVehicleTypeCard(VehiclesControllerImp controller, String type, String imageAsset) {
  return GestureDetector(
    onTap: () {
      controller.vehicle_type.text = type;
      controller.update();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 115,
      decoration: BoxDecoration(
        color: controller.vehicle_type.text == type
            ? AppColor.primaryColor.withOpacity(0.2)
            : AppColor.backgroundcolor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: controller.vehicle_type.text == type ? AppColor.primaryColor : Colors.grey,
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
          Stack(
            children: [
              Image.asset(
                imageAsset,
                width: 99,
                height: 99,
                fit: BoxFit.cover,
              ),
              if (controller.vehicle_type.text == type)
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: AppColor.primaryColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
