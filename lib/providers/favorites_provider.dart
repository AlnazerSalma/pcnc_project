import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void toggleFavorite(Map<String, dynamic> product) {
    if (_favorites.any((item) => item['id'] == product['id'])) {
      _favorites.removeWhere((item) => item['id'] == product['id']);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favorites.any((item) => item['id'] == productId);
  }
}
