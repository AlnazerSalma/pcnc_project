import 'package:flutter/material.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/favorite/domain/usecases/manage_favorites_usecase.dart';

class FavouriteProvider extends ChangeNotifier {
  final ManageFavoritesUseCase manageFavoritesUseCase;
  List<Product> _favorites = [];

  FavouriteProvider(this.manageFavoritesUseCase);

  List<Product> get favorites => _favorites;

  Future<void> initialize() async {
    await _getUserFavorites();
  }

  Future<void> _getUserFavorites() async {
    try {
      final products = await manageFavoritesUseCase.getFavoriteProducts();

      _favorites = products;

      notifyListeners();
    } catch (error) {
      print('Failed to fetch user favorites: $error');
    }
  }

  Future<void> toggleFavorite(Product product) async {
    if (_favorites.any((item) => item.id == product.id)) {
      await manageFavoritesUseCase.removeFavoriteProduct(product);
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      await manageFavoritesUseCase.addFavoriteProduct(product);
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favorites.any((item) => item.id == productId);
  }
}
