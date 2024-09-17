import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/application_manager/navigation_manager.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';
import 'package:pcnc/features/category/domain/manager/category_manager.dart';
import 'package:pcnc/presentation/widget/grid_view/custom_grid_view.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:pcnc/features/product/presentation/view/category_products_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/features/category/presentation/widget/category_card_widget.dart';
import 'package:pcnc/features/product/presentation/widgets/search_widget.dart';
import 'package:pcnc/presentation/widget/app_bar_widget/custom_app_bar.dart';

class AllCategoriesScreen extends StatefulWidget {
  final GetCategoriesUseCase getCategoriesUseCase;

  AllCategoriesScreen({required this.getCategoriesUseCase});

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  late CategoryDataManager _categoryDataManager;
  late NavigationManager _navigationManager;

  @override
  void initState() {
    super.initState();
    _categoryDataManager = CategoryDataManager(
      fetchData: () => widget.getCategoriesUseCase.execute(),
    );
    _categoryDataManager.loadData();
    _navigationManager = NavigationManager(context);
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;

    return ChangeNotifierProvider<CategoryDataManager>(
      create: (_) => _categoryDataManager,
      child: Scaffold(
        appBar: CustomAppBar(
          title: appLocale.categories,
          color: kbuttoncolorColor,
        ),
        body: Consumer<CategoryDataManager>(
          builder: (context, dataManager, child) {
            if (dataManager.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (dataManager.error != null) {
              return Center(
                child: CustomText(
                  text: '${appLocale.error} ${dataManager.error}',
                ),
              );
            }
            final filteredCategories = dataManager.filteredData;
            return Column(
              children: [
                SearchWidget(
                  hintText: appLocale.searchCategory,
                  onChanged: (query) {
                    dataManager.updateSearchQuery(query);
                  },
                ),
                Expanded(
                  child: filteredCategories.isEmpty
                      ? Center(
                          child: CustomText(
                            text: appLocale.noCategoriesFound,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(16.w),
                          child: CustomGridView<Category>(
                            items: filteredCategories,
                            itemBuilder: (context, category) {
                              return CategoryCardWidget(
                                category: category,
                                onTap: () {
                                  _navigationManager.navigateTo(
                                    CategoryProductsScreen(
                                      categoryId: category.id,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
