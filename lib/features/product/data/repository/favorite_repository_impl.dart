import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/repository/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final List<Product> _favorites = [];

  @override
  Future<List<Product>> getFavoriteProducts() async {
    return _favorites;
  }

  @override
  Future<void> addFavoriteProduct(Product product) async {
    _favorites.add(product);
  }

  @override
  Future<void> removeFavoriteProduct(Product product) async {
    _favorites.remove(product);
  }
}