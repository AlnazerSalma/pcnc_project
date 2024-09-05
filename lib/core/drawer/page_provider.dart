import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int selectedIndex = 0;

  onTappedIndex(index) {
    selectedIndex = index;
    notifyListeners();
  }
}

