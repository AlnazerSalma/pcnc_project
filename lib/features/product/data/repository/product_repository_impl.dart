import 'package:pcnc/core/app_service/api_service.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';

class ProductRepositoryImpl {
  final ApiService apiService;

  ProductRepositoryImpl(this.apiService);
   Future<List<Product>> getProductsByCategory(int categoryId) async {
    final data = await apiService.getProductsByCategory(categoryId);
    return data.map((model) => model.toEntity()).toList();
  }
  Future<List<Product>> getProducts({int offset = 0, int limit = 10}) async {
    final data = await apiService.getProducts(offset: offset, limit: limit);
    return data.map((model) => model.toEntity()).toList();
  }
}
