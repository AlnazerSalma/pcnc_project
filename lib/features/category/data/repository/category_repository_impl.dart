import 'package:pcnc/data/app_service/api_service.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';

class CategoryRepositoryImpl {
  final ApiService apiService;

  CategoryRepositoryImpl(this.apiService);

  Future<List<Category>> getCategories() async {
    final data = await apiService.getCategories();
    return data.map<Category>((model) => model.toEntity()).toList();
  }
}
