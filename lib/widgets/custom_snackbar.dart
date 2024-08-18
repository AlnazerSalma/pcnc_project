import 'package:flutter/material.dart';
import 'package:pcnc/util/color_palette.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: isError ? kWhiteColor: Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isError ? kRed : Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
