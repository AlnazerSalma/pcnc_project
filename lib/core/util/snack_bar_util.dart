import 'package:flutter/material.dart';
import 'package:pcnc/core/presentation/style/color_palette.dart';
import 'package:pcnc/core/presentation/style/font_sizes.dart';

SnackBar getSnackBar(String message, Color backgroundColor) {
  SnackBar snackBar = SnackBar(
    content: Text(message,
        style: const TextStyle(fontSize: textMedium, color: kWhiteColor)),
    backgroundColor: backgroundColor,
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
  );
  return snackBar;
}
