import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/aa/core/constant/font_sizes.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Settings Page",
          style: TextStyle(fontSize: textXExtraLarge.sp),
        ),
      ),
    );
  }
}
