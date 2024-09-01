import 'package:flutter/material.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/util/font_sizes.dart';
import 'package:pcnc/util/snack_bar_util.dart';

class CustomSnackBarWidget {
  static void show(BuildContext context, String message, {bool isError = false}) {
    Color backgroundColor = isError ? kRed : Theme.of(context).colorScheme.primary;
    SnackBar snackBar = getSnackBar(message, backgroundColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
