
import 'package:pcnc/aa/features/product/data/repository/product_repository.dart';
import 'package:pcnc/aa/features/product/domain/entity/product.dart';

class GetProductsUseCase {
  final ProductRepository productRepository;

  GetProductsUseCase(this.productRepository);

  Future<List<ProductEntity>> execute(int categoryId) async {
    return await productRepository.getProductsByCategory(categoryId);
  }
  Future<List<ProductEntity>> getProducts({int offset = 0, int limit = 10}) async {
    return await productRepository.getProducts(offset: offset, limit: limit);
  }
}
