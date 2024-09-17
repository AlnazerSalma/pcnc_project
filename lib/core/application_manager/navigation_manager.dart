import 'package:flutter/material.dart';
import 'package:pcnc/core/extension/navigator_ext.dart';

class NavigationManager with NavigatorHelper {
  static final NavigationManager _instance = NavigationManager._internal();

  factory NavigationManager() {
    return _instance;
  }

  NavigationManager._internal();

  // Simple navigation
  Future<dynamic> navigateTo(BuildContext context, Widget screen,
      {bool replace = false}) {
    return jumpTo(context, to: screen, replace: replace);
  }

  // Pop the current screen
  void pop(BuildContext context, {Function()? action}) {
    context.popIt(action: action);
  }

  // Pop until a specific route
  void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  // Navigate to a named route
  Future<dynamic> navigateToNamed(BuildContext context, String routeName,
      {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, routeName);
    } else {
      return Navigator.pushNamed(context, routeName);
    }
  }

  Future<dynamic> replaceWith(BuildContext context, Widget screen) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );
  }
}

// Usage Example:
// NavigationManager().navigateTo(context, SomeScreen());
// NavigationManager().pop(context);
// NavigationManager().replaceWith(context, SomeScreen());


