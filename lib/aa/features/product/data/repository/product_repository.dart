import 'package:pcnc/ApiService/api_service.dart';
import 'package:pcnc/aa/features/product/domain/entity/product.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);
   Future<List<ProductEntity>> getProductsByCategory(int categoryId) async {
    final data = await apiService.getProductsByCategory(categoryId);
    return data.map((model) => model.toEntity()).toList();
  }
  Future<List<ProductEntity>> getProducts({int offset = 0, int limit = 10}) async {
    final data = await apiService.getProducts(offset: offset, limit: limit);
    return data.map((model) => model.toEntity()).toList();
  }
}
