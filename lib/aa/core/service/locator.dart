import 'package:get_it/get_it.dart';
import 'package:pcnc/ApiService/api_service.dart';
import 'package:pcnc/aa/features/cart/data/repository/cart_repository.dart';
import 'package:pcnc/aa/features/cart/domain/usecase/add_to_cart_use_case.dart';
import 'package:pcnc/aa/features/category/data/repository/category_repository.dart';
import 'package:pcnc/aa/features/category/domain/usecases/get_categories_use_case.dart';
import 'package:pcnc/aa/features/product/data/repository/product_repository.dart';
import 'package:pcnc/aa/features/product/domain/usecase/get_products_use_case.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiService>(() => ApiService());

  locator.registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(locator<ApiService>()));
  locator.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(locator<CategoryRepository>()));
//========================================================================
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepository(locator<ApiService>()));
  locator.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(locator<ProductRepository>()));
//=====================================================================
  locator.registerLazySingleton<CartRepository>(() => CartRepository(locator<ApiService>()));
  locator.registerLazySingleton(() => AddToCartUseCase(locator<CartRepository>()));
  locator.registerLazySingleton(() => RemoveFromCartUseCase(locator<CartRepository>()));
  locator.registerLazySingleton(() => UpdateQuantityUseCase(locator<CartRepository>()));
  locator.registerLazySingleton(() => GetCartItemsUseCase(locator<CartRepository>()));
  locator.registerLazySingleton(() => GetTotalPriceUseCase(locator<CartRepository>()));
}
