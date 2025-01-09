import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:spotlocator/view/widget/custom_drawer.dart';
import '../../controller/parkinglot_controller.dart';
import '../../controller/vehicle_controller.dart';
import '../../core/class/handlingdataview.dart';
import '../../core/constant/color.dart';
import '../../linkapi.dart';
import '../widget/book_spot_bottom_sheet.dart';
import '../widget/custom_app_bar.dart';
import '../widget/custom_elevated_button.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ParkinglotsTableState();
}

class _ParkinglotsTableState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(VehiclesControllerImp());
    final controller = Get.put(ParkingLotControllerImp());

    return Scaffold(
        appBar: CustomAppBar(
          title: 'Reservation',
          icon: FontAwesomeIcons.calendarCheck,
          actions: [
            IconButton(
              onPressed: () async {
                // controller.buttumupdate();
              },
              icon: const FaIcon(FontAwesomeIcons.arrowsRotate,
                  color: Colors.white),
            ),
          ],
        ),
        drawer: CustomDrawer(),
        body: const Center(
          child: Text('Reservation'),
        ));
  }
}
