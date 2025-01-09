import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotlocator/view/widget/custom_app_bar.dart';
import 'package:spotlocator/view/widget/custom_elevated_button.dart';
import 'package:spotlocator/view/widget/custom_drawer.dart';
import '../../controller/profile_controller.dart';
import '../../core/constant/color.dart';
import '../../core/constant/imageasset.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileScreenControllerImp controller =
        Get.put(ProfileScreenControllerImp());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        icon: FontAwesomeIcons.userAstronaut,
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GetBuilder<ProfileScreenControllerImp>(
          builder: (controller) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0062CA),
                        Color(0xFF008FFF),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(AppImageAsset.profile),
                      ),
                      const SizedBox(height: 10),
                      controller.username != null
                          ? Text(
                              controller.username!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          : _shimmerPlaceholder(150, 20),
                      const SizedBox(height: 5),
                      controller.email != null
                          ? Text(
                              controller.email!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            )
                          : _shimmerPlaceholder(200, 16),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Simplify your parking with SpotLocator. Find, reserve, and manage parking spots effortlessly.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0062CA),
                        Color(0xFF008FFF),
                      ],
                      begin: Alignment.center,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        ProfileTile(
                          icon: Icons.phone,
                          title: 'PHONE',
                          subtitle: controller.phone ?? 'Loading...',
                        ),
                        ProfileTile(
                          icon: Icons.calendar_today,
                          title: 'JOIN DATE',
                          subtitle: controller.users_create ?? 'Loading...',
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.logout();
                    },
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'SIGN OUT',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _shimmerPlaceholder(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ProfileTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColor.primaryColor,
            size: 30,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
