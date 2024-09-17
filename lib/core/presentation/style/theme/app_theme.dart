import 'package:flutter/material.dart';
import '../../../constant/color_palette.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color.fromARGB(255, 255, 255, 255),
      primary: Color.fromARGB(255, 221, 221, 225),
      surface: Color(0xff000000),
      onInverseSurface: kBlackColor,
      error: kRed,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xFF121212),
      primary: Color.fromARGB(255, 30, 30, 30),
      surface: kWhiteColor,
      onInverseSurface: Color.fromARGB(255, 232, 230, 230),
      error: kRed,
    ),
  );
}
