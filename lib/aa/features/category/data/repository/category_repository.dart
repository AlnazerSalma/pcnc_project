import 'package:pcnc/ApiService/api_service.dart';
import 'package:pcnc/aa/features/category/domain/entity/category.dart';

class CategoryRepository {
  final ApiService apiService;

  CategoryRepository(this.apiService);

  Future<List<Category>> getCategories() async {
    final data = await apiService.getCategories();
    return data.map<Category>((model) => model.toEntity()).toList();
  }
}
