import 'package:pcnc/core/application_manager/data_manager.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';

class ProductDataManager extends DataManager<Product> {
  ProductDataManager(GetProductsUseCase getProductsUseCase)
      : super(fetchData: getProductsUseCase.getProducts);

  @override
  bool matchesSearchQuery(Product item) => item.title.toLowerCase().contains(searchQuery.toLowerCase());
}