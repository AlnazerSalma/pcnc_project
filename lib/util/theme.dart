import 'package:flutter/material.dart';

import 'color_palette.dart';

class ThemeDataStyle {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Color.fromARGB(255, 255, 255, 255),
      primary: Color.fromARGB(255, 221, 221, 225),
      surface: Color(0xff000000),
      onInverseSurface: kBlackColor,
      // secondary:  Color(0xFF0050E8),
      // onBackground: Color.fromARGB(255, 1, 49, 53),
      // onTertiary: Color(0xFFD6D6D6),
      // onSurface:Color(0xFFD6D6D6),
      // onPrimary: kGrey2,
      // onSecondaryContainer:  Color(0xFFCFD8DC),
      // onInverseSurface: Color(0xFF94D788),
      // onSurfaceVariant: Color(0xFF546E7A),
      // onPrimaryContainer:Color.fromARGB(155, 225, 245, 254) ,
      error: kRed,
    ),
    // textTheme: TextTheme(
    //   bodyLarge: TextStyle(color: kBlackColor),
    //   bodyMedium: TextStyle(
    //     color: Color(0xff555555),
    //   ),
    // ),
    // iconTheme: IconThemeData(
    //   color: Color(0xff555555), 
    // ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Color(0xFF121212),
      primary: Color.fromARGB(255, 30, 30, 30),
      surface: kWhiteColor,
      onInverseSurface: Color.fromARGB(255, 232, 230, 230),
      // secondary: Color(0xFF0050E8),
      // onBackground: Color(0xFF00838F),
      // onTertiary: Color(0xFF1E1E1E),
      // onSurface:kWhiteColor,
      // onPrimary: kblueColor,
      // error: kRed,
      // onSecondaryContainer:  const Color(0xFF8C8E97),
      // onSurfaceVariant: kGrey2,
      // onPrimaryContainer:kGrey2,
    ),
    // textTheme: TextTheme(
    //   bodyLarge: TextStyle(color: kWhiteColor),
    //   bodyMedium: TextStyle(
    //     color: Color(0xffCCCCCC),
    //   ),
    // ),
    //  iconTheme: IconThemeData(
    //   color: Color(0xffCCCCCC), 
    // ),
    
  );
}
