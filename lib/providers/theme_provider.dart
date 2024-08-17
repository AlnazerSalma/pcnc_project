import 'package:pcnc/cache/cache_controller.dart';
import 'package:pcnc/enums.dart';
import 'package:pcnc/util/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeDataStyle;

  ThemeProvider(ThemeData initialThemeMode) {
    _themeDataStyle = initialThemeMode;
  }

  ThemeData get themeDataStyle => _themeDataStyle;

  set themeDataStyle(ThemeData themeData) {
    _themeDataStyle = themeData;
    CacheController().setter(key: CacheKeys.theme, value: themeDataStyle == ThemeDataStyle.light ? 'light' : 'dark');
    notifyListeners();
  }

  void updateTheme(bool isDarkMode) {
    themeDataStyle = isDarkMode ? ThemeDataStyle.dark : ThemeDataStyle.light;
  }
  void changeTheme() {
    if (_themeDataStyle == ThemeDataStyle.light) {
      themeDataStyle = ThemeDataStyle.dark;
    } else {
      themeDataStyle = ThemeDataStyle.light;
    }
  }
  void toggleTheme() {
    if (_themeDataStyle == ThemeDataStyle.light) {
      updateTheme(true);
    } else {
      updateTheme(false);
    }
  }
}