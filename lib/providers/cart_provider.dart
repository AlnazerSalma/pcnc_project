import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartItems.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  bool isInCart(int id) {
    return _cartItems.any((item) => item['id'] == id);
  }
}
