import 'package:pcnc/features/category/domain/entity/category.dart';
import 'package:pcnc/features/category/data/repository/category_repository_impl.dart';

class GetCategoriesUseCase {
  final CategoryRepositoryImpl categoryRepository;

  GetCategoriesUseCase(this.categoryRepository);

  Future<List<Category>> execute() async {
    return await categoryRepository.getCategories();
  }
}
