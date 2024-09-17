import 'package:pcnc/core/application_manager/data_manager.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';

class CategoryDataManager extends DataManager<Category> {
  CategoryDataManager({required Future<List<Category>> Function() fetchData})
      : super(fetchData: fetchData);

  @override
  bool matchesSearchQuery(Category category) {
    return category.name.toLowerCase().contains(searchQuery.toLowerCase());
  }
}
