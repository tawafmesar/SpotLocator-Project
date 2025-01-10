import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spotlocator/controller/reservation_controller.dart';
import 'package:spotlocator/view/widget/custom_drawer.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';
import '../../linkapi.dart';
import '../widget/animated_image_switcher.dart';
import '../widget/book_spot_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_elevated_button.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReservationControllerImp());

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reservation',
        icon: FontAwesomeIcons.calendarCheck,
        actions: [
          IconButton(
            onPressed: () async {
              controller.getReservationData();
            },
            icon: const FaIcon(FontAwesomeIcons.arrowsRotate,
                color: Colors.white),
          ),
        ],
      ),
      drawer: CustomDrawer(),
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
                  placeholder: 'Search Reservations',
                  style: const TextStyle(color: AppColor.primaryColor),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(133, 156, 197, 255),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (value) {
                    controller.setSearchQuery(value);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.filter_list, color: AppColor.primaryColor),
                    const SizedBox(width: 10),
                    DropdownButton<int?>(
                      value: controller.selectedStatus,
                      hint: const Text('Filter by Status'),
                      items: const [
                        DropdownMenuItem<int?>(value: null, child: Text('All')),
                        DropdownMenuItem<int>(value: 0, child: Text('Pending')),
                        DropdownMenuItem<int>(
                            value: 1, child: Text('Checkout')),
                        DropdownMenuItem<int>(
                            value: 2, child: Text('Canceled')),
                      ],
                      onChanged: (value) {
                        controller.setSelectedStatus(value);
                      },
                    ),
                  ],
                ),
                GetBuilder<ReservationControllerImp>(
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
                          final reservation = controller.filteredData[index];
                          final backgroundColor = index % 2 == 0
                              ? const Color(0xFF9CC5FF)
                              : const Color(0xFF6B92F6);

                          return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              if (reservation.reservationStatus != 0) {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Action Not Allowed'),
                                      content: const Text(
                                        'The cancel action is only allowed for pending reservations. Other statuses cannot be canceled.',
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return false;
                              }

                              bool? confirm = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Cancel Reservation'),
                                    content: const Text(
                                        'Are you sure you want to cancel this reservation?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return confirm;
                            },
                            onDismissed: (direction) {
                              controller
                                  .cancel(reservation.reservationId.toString());
                              Get.snackbar(
                                "Reservation Canceled",
                                "Reservation ${reservation.reservationId} has been canceled.",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 2),
                              );
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.cancel,
                                  color: Colors.white, size: 30),
                            ),
                            child: Card(
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
                                    AnimatedImageSwitcher(
                                      networkImageUrl:
                                          "${AppLink.imagesstatic}/${reservation.departmentImage ?? ''}",
                                      assetImagePath: _getVehicleImage(
                                          reservation.vehicleType),
                                      backgroundColor: backgroundColor,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.locationDot,
                                                  color: AppColor.primaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                const Text(
                                                  'Spot Name: ',
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  reservation.parkingSpotName ??
                                                      'N/A',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons
                                                      .squareParking,
                                                  color: AppColor.primaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    reservation
                                                            .departmentName ??
                                                        'Unknown',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons
                                                      .calendarCheck,
                                                  color: AppColor.primaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    reservation
                                                            .reservationDate ??
                                                        'Unknown',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.car,
                                                  color: AppColor.primaryColor,
                                                ),
                                                const SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    '${reservation.vehiclePlate ?? 'Unknown'} - ${reservation.vehicleDesc ?? 'Unknown'}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            _buildStatusWidget(
                                                reservation.reservationStatus),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusWidget(int? reservationStatus) {
    String statusText;
    IconData statusIcon;
    Color backgroundColor;

    switch (reservationStatus) {
      case 0:
        statusText = 'Pending';
        statusIcon = Icons.pending_actions;
        backgroundColor = Colors.orange.shade100;
        break;
      case 1:
        statusText = 'Checkout';
        statusIcon = Icons.check_circle;
        backgroundColor = Colors.green.shade100;
        break;
      case 2:
        statusText = 'Canceled';
        statusIcon = Icons.cancel;
        backgroundColor = Colors.red.shade100;
        break;
      default:
        statusText = 'N/A';
        statusIcon = Icons.help_outline;
        backgroundColor = Colors.grey.shade200;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.circleInfo,
            color: AppColor.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 5),
          const Text(
            'Status: ',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          Text(
            statusText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 5),
          Icon(
            statusIcon,
            color: AppColor.primaryColor,
            size: 24,
          ),
        ],
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
}
