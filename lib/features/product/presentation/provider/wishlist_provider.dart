import 'package:flutter/material.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_use_case.dart';

class WishListProvider extends ChangeNotifier {
  final GetProductsUseCase getProductsUseCase;
  List<Product> _favorites = [];
  String? _token;
  WishListProvider(this.getProductsUseCase);
  List<Product> get favorites => _favorites;
  Future<void> initialize(String token) async {
    _token = token;
    await _fetchUserFavorites();
  }

  Future<void> _fetchUserFavorites() async {
    if (_token == null) return;

    try {
      final products = await getProductsUseCase.getProducts();

      _favorites = products;

      notifyListeners();
    } catch (error) {
      print('Failed to fetch user favorites: $error');
    }
  }

  void toggleFavorite(Product product) {
    if (_favorites.any((item) => item.id == product.id)) {
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favorites.any((item) => item.id == productId);
  }
}
