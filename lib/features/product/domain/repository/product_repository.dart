import 'package:pcnc/features/product/domain/entity/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductsByCategory(int categoryId);
  Future<List<Product>> getProducts({int offset, int limit});
}
