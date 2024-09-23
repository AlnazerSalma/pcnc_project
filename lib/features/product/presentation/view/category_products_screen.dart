import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/data/service/locator.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';
import 'package:pcnc/features/category/domain/manager/category_manager.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/manager/product_category_manager.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/widget/app_bar_widget/custom_app_bar.dart';
import 'package:pcnc/presentation/widget/grid_view/custom_grid_view.dart';
import 'package:pcnc/presentation/widget/search_widget.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;

  CategoryProductsScreen({required this.categoryId});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  late final ProductCategoryManager productCategoryManager;
  late final CategoryDataManager categoryDataManager;

  @override
  void initState() {
    super.initState();
    productCategoryManager = ProductCategoryManager(
      categoryId: widget.categoryId,
      getProductsUseCase: locator<GetProductsUseCase>(),
    );
    categoryDataManager = CategoryDataManager(
      fetchData: () => locator<GetCategoriesUseCase>().execute(),
    );

    productCategoryManager.loadData();
    categoryDataManager.loadData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));

    return Scaffold(
      appBar: CustomAppBar<Category>(
        futureData: Future.value(
          categoryDataManager.filteredData.firstWhere(
            (category) => category.id == widget.categoryId,
            orElse: () => Category(
                id: widget.categoryId, name: appLocale.unknown, image: null),
          ),
        ),
        dataToString: (category) => category.name,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
        color: kbuttoncolorColor,
      ),
      body: Column(
        children: [
          SearchWidget(
            hintText: appLocale.searchProduct,
            onChanged: (query) {
              setState(() {
                productCategoryManager.updateSearchQuery(query);
              });
            },
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: productCategoryManager,
              builder: (context, _) {
                if (productCategoryManager.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (productCategoryManager.error != null) {
                  return Center(
                      child: CustomText(
                          text:
                              '${appLocale.error} ${productCategoryManager.error}'));
                } else if (productCategoryManager.filteredData.isEmpty) {
                  return Center(child: CustomText(text: appLocale.noProductsAvailable));
                } else {
                  return CustomGridView<Product>(
                    items: productCategoryManager.filteredData,
                    itemBuilder: (context, product) =>
                        ProductCardWidget(product: product),
                  );
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
