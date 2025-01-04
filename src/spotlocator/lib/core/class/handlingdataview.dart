import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spotlocator/core/class/statusrequest.dart';
import '../constant/color.dart';
import '../constant/imageasset.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView({
    Key? key,
    required this.statusRequest,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
      child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250),
    )
        : statusRequest == StatusRequest.offlinefailure
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppImageAsset.offline, width: 250, height: 250),
          const SizedBox(height: 20),
          const Text(
            "No internet connection.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    )
        : statusRequest == StatusRequest.serverfailure
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppImageAsset.server, width: 250, height: 250),
          const SizedBox(height: 20),
          const Text(
            "Server error occurred.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    )
        : statusRequest == StatusRequest.failure
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppImageAsset.noData,
            width: 250,
            height: 250,
            repeat: true,
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          const AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: 1.0,
            child: Text(
              "No Data Found, You can add",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:  AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    )
        : widget;
  }
}

class HandlingDataViewRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;


  const HandlingDataViewRequest({
    Key? key,
    required this.statusRequest,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
      child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250),
    )
        : statusRequest == StatusRequest.offlinefailure
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppImageAsset.offline, width: 250, height: 250),
          const SizedBox(height: 20),
          const Text(
            "No internet connection.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    )
        : statusRequest == StatusRequest.serverfailure
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppImageAsset.server, width: 250, height: 250),
          const SizedBox(height: 20),
          const Text(
            "Server error occurred.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    )
        : widget;
  }
}
