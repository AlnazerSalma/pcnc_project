import 'package:pcnc/data/app_service/api_service.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService apiService;

  @override
  ProductRepositoryImpl(this.apiService);
  Future<List<Product>> getProductsByCategory(int categoryId) async {
    final data = await apiService.getProductsByCategory(categoryId);
    return data.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Product>> getProducts({int offset = 0, int limit = 10}) async {
    final data = await apiService.getProducts(offset: offset, limit: limit);
    return data.map((model) => model.toEntity()).toList();
  }
}
