import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationManager {
  /// Pops the current screen & performs optional action
  void popScreen({Function()? action}) {
    if (action != null) {
      action();
    }
    Get.back();
  }

  /// Navigates to a new screen without replacing the current one
  Future<dynamic>? navigateTo(Widget screen) {
    return Get.to(() => screen);
  }

  /// Replaces the current screen with a new one
  Future<dynamic>? replaceWith(Widget screen) {
    return Get.off(() => screen);
  }

  /// Navigates to a new screen and removes all previous screens
  Future<dynamic>? navigateAndRemoveUntil(Widget screen) {
    return Get.offAll(() => screen);
  }
}
