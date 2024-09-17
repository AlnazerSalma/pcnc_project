import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void onTappedIndex(int? index) {
    selectedIndex = index ?? 0;
    notifyListeners();
  }
}
