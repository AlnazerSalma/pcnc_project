import 'package:pcnc/core/application_manager/data_manager.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';

class ProductCategoryManager extends DataManager<Product> {
  final int categoryId;
  final GetProductsUseCase getProductsUseCase;

  ProductCategoryManager({
    required this.categoryId,
    required this.getProductsUseCase,
  }) : super(fetchData: () => getProductsUseCase.execute(categoryId));

  @override
  bool matchesSearchQuery(Product item) => item.title.toLowerCase().contains(searchQuery.toLowerCase());
}
