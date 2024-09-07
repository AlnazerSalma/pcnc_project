import 'package:get_it/get_it.dart';
import 'package:pcnc/core/app_service/api_service.dart';
import 'package:pcnc/features/cart/data/repository/cart_repository_impl.dart';
import 'package:pcnc/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:pcnc/features/category/data/repository/category_repository_impl.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:pcnc/features/product/data/repository/favorite_repository_impl.dart';
import 'package:pcnc/features/product/data/repository/product_repository_impl.dart';
import 'package:pcnc/features/product/domain/repository/favorite_repository.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';
import 'package:pcnc/features/product/domain/usecase/manage_favorites_usecase.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiService>(() => ApiService());

  locator.registerLazySingleton<CategoryRepositoryImpl>(
      () => CategoryRepositoryImpl(locator<ApiService>()));
  locator.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(locator<CategoryRepositoryImpl>()));
//========================================================================
  locator.registerLazySingleton<ProductRepositoryImpl>(
      () => ProductRepositoryImpl(locator<ApiService>()));
  locator.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(locator<ProductRepositoryImpl>()));
//=====================================================================
  locator.registerLazySingleton<CartRepositoryImpl>(() => CartRepositoryImpl(locator<ApiService>()));
  locator.registerLazySingleton(() => AddToCartUseCase(locator<CartRepositoryImpl>()));
  locator.registerLazySingleton(() => RemoveFromCartUseCase(locator<CartRepositoryImpl>()));
  locator.registerLazySingleton(() => UpdateQuantityUseCase(locator<CartRepositoryImpl>()));
  locator.registerLazySingleton(() => GetCartItemsUseCase(locator<CartRepositoryImpl>()));
  locator.registerLazySingleton(() => GetTotalPriceUseCase(locator<CartRepositoryImpl>()));
//=============================================================
 locator.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl());
locator.registerLazySingleton(() => ManageFavoritesUseCase(locator<FavoriteRepository>()));
}
