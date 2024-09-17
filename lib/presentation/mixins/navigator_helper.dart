import 'package:flutter/material.dart';

mixin NavigatorHelper {
  Future<dynamic> jumpTo(
    BuildContext context, {
    required Widget to,
    bool replace = false,
  }) async  {
    if (!replace) {
      return await Navigator.push(
          context, MaterialPageRoute(builder: (context) => to));
    } else {
      return await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => to));
    }
  }
}