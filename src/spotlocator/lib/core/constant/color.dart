import 'package:flutter/material.dart';
class AppColor {
  static const Color grey = Color(0xff8e8e8e);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffffffff);

  // static const Color primaryColor = Color(0xff5DB1DF);
  static const Color backgroundcolor = Color(0xffF3F8FC) ;
  static const Color primaryColor = Color(0xff008FFF);
  static const Color primaryColor2 = Color(0xff10A9AE);


  static const Color primaryColor3 = Color(0xb310a9ae);
  static const Color text = Color(0xff023336);

  static const Color bottombar = Color(0xff343434);


  static const Color scaffoldBackgroundColor = const Color(0xFF343541);
  static const Color cardColor = const Color(0xFF444654);

  static const Color secoundColor = Color(0xff2FA5AA);
  static const Color secoundColor2 = Color(0xff10A9AE);


  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = Color(0xFF2D2F41);
  static Color menuBackgroundColor = Color(0xFF242634);
//A13562  F07B87
  static Color clockBG = Color(0xFF444974);
  static Color clockOutline = Color(0xFFEAECFF);
  static Color? secHandColor = Colors.orange[300];
  static Color minHandStatColor = Color(0xFF748EF6);
  static Color minHandEndColor = Color(0xFF77DDFF);
  static Color hourHandStatColor = Color(0xFFC279FB);
  static Color hourHandEndColor = Color(0xFFEA74AB);
  static const Color grey2 = Color(0xffd5d4d4);

}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
