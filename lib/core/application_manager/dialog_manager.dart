import 'package:flutter/material.dart';

class DialogManager {
  static Future<void> showDialogWidget<T>(
      BuildContext context, Widget dialogWidget) {
    return showDialog<T>(
      context: context,
      builder: (context) => dialogWidget,
    );
  }
}
