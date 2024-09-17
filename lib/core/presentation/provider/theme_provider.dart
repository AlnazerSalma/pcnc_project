import 'package:pcnc/core/presentation/controller/cache_controller.dart';
import 'package:pcnc/core/enum/cache_keys.dart';
import 'package:pcnc/core/presentation/style/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _AppTheme;

  ThemeProvider(ThemeData initialThemeMode) {
    _AppTheme = initialThemeMode;
  }

  ThemeData get themeDataStyle => _AppTheme;

  set themeDataStyle(ThemeData themeData) {
    _AppTheme = themeData;
    CacheController().setter(
        key: CacheKeys.theme,
        value: themeDataStyle == AppTheme.light ? 'light' : 'dark');
    notifyListeners();
  }

  void updateTheme(bool isDarkMode) {
    themeDataStyle = isDarkMode ? AppTheme.dark : AppTheme.light;
  }

  void changeTheme() {
    if (_AppTheme == AppTheme.light) {
      themeDataStyle = AppTheme.dark;
    } else {
      themeDataStyle = AppTheme.light;
    }
  }

  void toggleTheme() {
    if (_AppTheme == AppTheme.light) {
      updateTheme(true);
    } else {
      updateTheme(false);
    }
  }
}
