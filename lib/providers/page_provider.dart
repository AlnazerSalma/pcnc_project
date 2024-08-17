import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int selectedIndex = 0;

  onTapSelectedIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

