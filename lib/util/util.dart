import 'package:pcnc/util/font_sizes.dart';
import 'package:flutter/material.dart';
SnackBar getSnackBar(String message, Color backgroundColor) {
  SnackBar snackBar = SnackBar(
    content: Text(message,
        style: const TextStyle(fontSize: textMedium)),
    backgroundColor: backgroundColor,
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
  );
  return snackBar;
}