import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pcnc/core/constant/strings.dart';
import 'package:pcnc/core/enum/e_app_languages.dart';
import 'package:pcnc/features/category/domain/manager/category_manager.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:pcnc/features/product/domain/manager/product_data_manager.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';
import 'package:pcnc/presentation/drawer/provider/page_provider.dart';
import 'package:pcnc/presentation/provider/theme_provider.dart';
import 'package:pcnc/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:pcnc/presentation/bloc/state_observer_bloc.dart';
import 'package:pcnc/presentation/controller/cache_controller.dart';
import 'package:pcnc/core/enum/e_cache_keys.dart';
import 'package:pcnc/presentation/widget/restart_app.dart';
import 'package:pcnc/data/service/locator.dart';
import 'package:pcnc/features/cart/presentation/provider/cart_provider.dart';
import 'package:pcnc/features/favorite/domain/usecases/manage_favorites_usecase.dart';
import 'package:pcnc/features/favorite/presentation/provider/favourite_provider.dart';
import 'package:pcnc/presentation/provider/lang_provider.dart';
import 'package:pcnc/features/other_features/splash/splash_screen.dart';
import 'package:pcnc/presentation/style/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart' as provider;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheController().initSharedPreferences();
  Bloc.observer = StateObserverBloc();
  String? theme = CacheController().getter(key: CacheKeys.theme);
  ThemeData initialThemeMode = theme == 'dark' ? AppTheme.dark : AppTheme.light;
  setupLocator();
  runApp(
    provider.ChangeNotifierProvider(
      create: (context) => ThemeProvider(initialThemeMode),
      child: riverpod.ProviderScope(child: App()),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _updateTheme());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _updateTheme() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    provider.Provider.of<ThemeProvider>(context, listen: false)
        .updateTheme(isDarkMode);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _updateTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414.0, 896.0),
      builder: (context, child) {
        return RestartApp(
          child: MultiProvider(
            providers:
            [
              ChangeNotifierProvider(create: (_) => LanguageProvider()),
              ChangeNotifierProvider(create: (context) => PageProvider()),
              ChangeNotifierProvider(
                  create: (_) =>
                      FavouriteProvider(locator<ManageFavoritesUseCase>())),
              ChangeNotifierProvider(
                create: (_) => CartProvider(
                  addToCartUseCase: locator<AddToCartUseCase>(),
                  removeFromCartUseCase: locator<RemoveFromCartUseCase>(),
                  updateQuantityUseCase: locator<UpdateQuantityUseCase>(),
                  getCartItemsUseCase: locator<GetCartItemsUseCase>(),
                  getTotalPriceUseCase: locator<GetTotalPriceUseCase>(),
                ),
              ),
              ChangeNotifierProvider(
                create: (context) =>
                    ProductDataManager(locator<GetProductsUseCase>()),
              ),
              ChangeNotifierProvider(
                create: (context) => CategoryDataManager(fetchData: () async {
                  final getCategoriesUseCase = locator<GetCategoriesUseCase>();
                  return await getCategoriesUseCase.execute();
                }),
              ),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return GetMaterialApp(
                  title: appTitle,
                  debugShowCheckedModeBanner: false,
                  theme: themeProvider.themeDataStyle,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLanguages.values
                      .map((language) => Locale(language.name))
                      .toList(),
                  locale: Locale(Provider.of<LanguageProvider>(context).lang),
                  home: const SplashScreen(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}