// import 'package:flutter/material.dart';

// class FavoritesProvider extends ChangeNotifier {
//   final List<Map<String, dynamic>> _favorites = [];

//   List<Map<String, dynamic>> get favorites => _favorites;

//   void toggleFavorite(Map<String, dynamic> product) {
//     if (_favorites.any((item) => item['id'] == product['id'])) {
//       _favorites.removeWhere((item) => item['id'] == product['id']);
//     } else {
//       _favorites.add(product);
//     }
//     notifyListeners();
//   }

//   bool isFavorite(int productId) {
//     return _favorites.any((item) => item['id'] == productId);
//   }
// }
import 'package:flutter/material.dart';

// class FavoritesProvider extends ChangeNotifier {
//   final List<Map<String, dynamic>> _favorites = [];

//   List<Map<String, dynamic>> get favorites => _favorites;

//   void toggleFavorite(Map<String, dynamic> product) {
//     if (_favorites.any((item) => item['id'] == product['id'])) {
//       _favorites.removeWhere((item) => item['id'] == product['id']);
//     } else {
//       _favorites.add(product);
//     }
//     notifyListeners();
//   }

//   bool isFavorite(int productId) {
//     return _favorites.any((item) => item['id'] == productId);
//   }
// }
import 'package:flutter/material.dart';
import 'package:pcnc/ApiService/api_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];
  String? _token;

  List<Map<String, dynamic>> get favorites => _favorites;

  // Method to initialize the provider with token
  Future<void> initialize(String token) async {
    _token = token;
    await _fetchUserFavorites();
  }

  Future<void> _fetchUserFavorites() async {
    if (_token == null) return;

    try {
      final apiService = ApiService();
      final response = await apiService.getProfile(_token!); // Use token!
      // Assuming the user's favorites are included in the profile response
      if (response != null && response.containsKey('favorites')) {
        _favorites.addAll(response['favorites']);
        notifyListeners();
      }
    } catch (error) {
      print('Failed to fetch user favorites: $error');
    }
  }

  void toggleFavorite(Map<String, dynamic> product) {
    if (_favorites.any((item) => item['id'] == product['id'])) {
      _favorites.removeWhere((item) => item['id'] == product['id']);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
    // Optionally, you can add code here to update the server with the new favorites list
  }

  bool isFavorite(int productId) {
    return _favorites.any((item) => item['id'] == productId);
  }
}