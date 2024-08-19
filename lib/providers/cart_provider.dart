import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    if (isInCart(product['id'])) {
      increaseQuantity(product['id']);
    } else {
      _cartItems.add({...product, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartItems.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  bool isInCart(int id) {
    return _cartItems.any((item) => item['id'] == id);
  }

  void increaseQuantity(int id) {
    final index = _cartItems.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 1) + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(int id) {
    final index = _cartItems.indexWhere((item) => item['id'] == id);
    if (index != -1 && (_cartItems[index]['quantity'] ?? 1) > 1) {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 1) - 1;
      notifyListeners();
    }
  }

  int getItemQuantity(int id) {
    final item = _cartItems.firstWhere((item) => item['id'] == id, orElse: () => {'quantity': 1});
    return item['quantity'] ?? 1;
  }
}
