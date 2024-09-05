import 'package:pcnc/aa/features/category/domain/entity/category.dart';
import 'package:pcnc/aa/features/category/data/repository/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository categoryRepository;

  GetCategoriesUseCase(this.categoryRepository);

  Future<List<Category>> execute() async {
    return await categoryRepository.getCategories();
  }
}
