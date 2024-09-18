import 'package:pcnc/features/product/domain/entity/product.dart';

abstract class FavoriteRepository {
  Future<List<Product>> getFavoriteProducts();
  Future<void> addFavoriteProduct(Product product);
  Future<void> removeFavoriteProduct(Product product);
}