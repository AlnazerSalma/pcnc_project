import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration buildInputDecoration(
  BuildContext context,
  String labelText,
  IconData icon,
) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
      color: getPrefixIconColor(context),
      size: 20.dm,
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: getLabelColor(context),
      fontSize: 13.sp,
      fontWeight: FontWeight.bold,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
    ),
  );
}

Color? getPrefixIconColor(BuildContext context) => Theme.of(context).iconTheme.color;
Color getLabelColor(BuildContext context) => Theme.of(context).colorScheme.surface;
