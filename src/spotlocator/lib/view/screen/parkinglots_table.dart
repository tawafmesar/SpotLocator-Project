import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controller/parkinglot_controller.dart';
import '../../controller/vehicle_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../linkapi.dart';
import '../widget/book_spot_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_elevated_button.dart';

class ParkinglotsTable extends StatefulWidget {
  const ParkinglotsTable({Key? key}) : super(key: key);

  @override
  State<ParkinglotsTable> createState() => _ParkinglotsTableState();
}

class _ParkinglotsTableState extends State<ParkinglotsTable> {
  @override
  Widget build(BuildContext context) {
    Get.put(VehiclesControllerImp());
    final controller = Get.put(ParkingLotControllerImp());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Parking Spots',
        icon: Icons.local_parking,
        actions: [
          IconButton(
            onPressed: () async {
              controller.buttumupdate();
            },
            icon: const FaIcon(FontAwesomeIcons.arrowsRotate, color: Colors.white),
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
              children: [
                CupertinoTextField(
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(Icons.search, color: AppColor.primaryColor),
                  ),
                  padding: const EdgeInsets.all(15),
                  placeholder: 'Search in Parking Spots',
                  style: const TextStyle(color: AppColor.primaryColor),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(133, 156, 197, 255),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (value) {
                    controller.setSearchQuery(value);
                  },
                ),
                const SizedBox(height: 15),

                GetBuilder<ParkingLotControllerImp>(
                  builder: (controller) {
                    if (controller.departments.isEmpty) {
                      return SizedBox();
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.filter_list, color: AppColor.primaryColor, size: 20),
                          const SizedBox(width: 10),

                          GestureDetector(
                            onTap: () {
                              controller.setSelectedDept(null); // Select 'All'
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: controller.selectedDeptId == null
                                    ? AppColor.primaryColor
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'All',
                                style: TextStyle(
                                  color: controller.selectedDeptId == null
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // Department Filters
                          ...controller.departments.map((dept) {
                            bool isSelected = controller.selectedDeptId == dept.deptId;
                            return GestureDetector(
                              onTap: () {
                                controller.setSelectedDept(dept.deptId);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColor.primaryColor : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      dept.deptShort,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                // Parking Spots List
                GetBuilder<ParkingLotControllerImp>(
                  builder: (controller) => HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: SizedBox(
                      height: MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          200,
                      child: ListView.builder(
                        itemCount: controller.filteredData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final parkingSpot = controller.filteredData[index];
                          final backgroundColor = index % 2 == 0
                              ? const Color(0xFF9CC5FF)
                              : const Color(0xFF6B92F6);

                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              color: AppColor.backgroundcolor,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: backgroundColor,
                                    child: CachedNetworkImage(
                                      height: 140,
                                      width: 140,
                                      fit: BoxFit.cover,
                                      imageUrl: "${AppLink.imagesstatic}/${parkingSpot.deptImage ?? ''}",
                                      placeholder: (context, url) =>
                                      const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error, size: 30, color: Colors.red),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 140,
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.location_on, size: 20, color: AppColor.primaryColor),
                                              const SizedBox(width: 5),
                                               Text(
                                                'Spot : ',
                                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                parkingSpot.spotName ?? 'N/A',
                                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                  color: AppColor.primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          const SizedBox(height: 5),
                                          Text(
                                            parkingSpot.deptName ?? 'Unknown',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Center(
                                            child: CustomElevatedButton(
                                              onPressed: () {
                                                controller.vehicle_id.clear();
                                                showBottomSheetBoxSpot(
                                                    context, parkingSpot.parkingspotId.toString()
                                                );
                                              } ,
                                              icon: Icons.book_online,
                                              text: 'Book Now',
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
