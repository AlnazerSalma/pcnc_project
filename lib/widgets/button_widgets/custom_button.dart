import 'package:pcnc/util/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Size? fixedSize;

  CustomButton({
    required this.onPressed,
    required this.buttonText,
    this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: fixedSize ?? Size(160.w, 57.h),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.50.r),
        ),
        side: BorderSide(
          width: 3.w,
          color: Color.fromARGB(255, 146, 177, 236),
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
