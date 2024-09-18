import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/features/category/domain/manager/category_manager.dart';
import 'package:pcnc/features/product/domain/manager/product_data_manager.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';
import 'package:pcnc/presentation/widget/search_widget.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/presentation/widget/app_bar_widget/custom_app_bar.dart';
import 'package:pcnc/presentation/widget/grid_view/custom_grid_view.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;

  CategoryProductsScreen({required this.categoryId});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  late Future<Category> category;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchQuery = '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productDataManager =
          Provider.of<ProductDataManager>(context, listen: false);
      productDataManager.loadData(); // Fetch products initially

    });
    // Fetch category based on provided ID
    category = fetchCategory(widget.categoryId);
  }

  Future<Category> fetchCategory(int categoryId) async {
    final categoryDataManager =
        Provider.of<CategoryDataManager>(context, listen: false);
    final categories = await categoryDataManager.fetchData();
    return categories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () =>
          Category(id: categoryId, name: appLocale.unknown, image: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));

    return Scaffold(
      appBar: CustomAppBar<Category>(
        futureData: category,
        dataToString: (category) => category.name,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
        color: kbuttoncolorColor,
      ),
      body: Consumer<ProductDataManager>(
        builder: (context, productDataManager, child) {
          return Column(
            children: [
              SearchWidget(
                hintText: appLocale.searchProduct,
                onChanged: (query) {
                  // Use a post-frame callback to update the search query
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      searchQuery = query;
                      productDataManager.updateSearchQuery(searchQuery);
                    });
                  });
                },
              ),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (productDataManager.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (productDataManager.error != null) {
                      return Center(
                          child: CustomText(
                              text:
                                  '${appLocale.error} ${productDataManager.error}'));
                    } else if (productDataManager.filteredData.isEmpty) {
                      return Center(
                          child:
                              CustomText(text: appLocale.noProductsAvailable));
                    } else {
                      final filteredProducts = productDataManager.filteredData;

                      if (filteredProducts.isEmpty) {
                        return Center(
                            child: CustomText(
                                text: appLocale.noProductsMatchYourSearch));
                      }
                      return CustomGridView<Product>(
                        items: filteredProducts,
                        itemBuilder: (context, product) =>
                            ProductCardWidget(product: product),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
