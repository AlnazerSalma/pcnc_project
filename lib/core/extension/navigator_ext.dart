import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  void popIt({Function()? action}) {
    Navigator.pop(this);
    if (action != null) {
      action;
    }
  }
}
