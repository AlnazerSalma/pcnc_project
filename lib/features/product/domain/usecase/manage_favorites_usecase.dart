import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/repository/favorite_repository.dart';

class ManageFavoritesUseCase {
  final FavoriteRepository favoriteRepository;

  ManageFavoritesUseCase(this.favoriteRepository);

  Future<List<Product>> getFavoriteProducts() {
    return favoriteRepository.getFavoriteProducts();
  }

  Future<void> addFavoriteProduct(Product product) {
    return favoriteRepository.addFavoriteProduct(product);
  }

  Future<void> removeFavoriteProduct(Product product) {
    return favoriteRepository.removeFavoriteProduct(product);
  }
}
