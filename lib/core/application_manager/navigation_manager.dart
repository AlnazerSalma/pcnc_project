import 'package:flutter/material.dart';
import 'package:pcnc/core/extension/navigator_ext.dart';
import 'package:pcnc/presentation/mixins/navigator_helper.dart';

class NavigationManager with NavigatorHelper {
  final BuildContext context;

  NavigationManager(this.context);

  /// Pops the current screen & performs optional action
  void popScreen({Function()? action}) {
    context.popIt(action: action);
  }

  /// Navigates to a new screen without replacing the current one
  Future<dynamic> navigateTo(Widget screen) {
    return jumpTo(context, to: screen, replace: false);
  }

  /// Replaces the current screen with a new one
  Future<dynamic> replaceWith(Widget screen) {
    return jumpTo(context, to: screen, replace: true);
  }

  /// Navigates to a new screen and removes all previous screens
  Future<dynamic> navigateAndRemoveUntil(Widget screen) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }
}
