import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controller/parkinglot_controller.dart';
import '../../controller/vehicle_controller.dart';
import '../../core/constant/color.dart';
import '../widget/custom_app_bar.dart';

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
      appBar:CustomAppBar(
        title: 'Parking Spots',
        icon: Icons.directions_car,
        actions: [
          IconButton(
            onPressed: () async {
              controller.buttumupdate();
            },
            icon: const FaIcon(FontAwesomeIcons.arrowsRotate),
          ),
        ],
      ),
    );
  }
}
