import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/constant/color_palette.dart';
import 'package:pcnc/core/constant/font_sizes.dart';
import 'package:pcnc/core/service/locator.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:pcnc/features/product/presentation/widgets/search_widget.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;

  CategoryProductsScreen({required this.categoryId});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  late Future<List<Product>> products;
  late Future<Category> category;
  String searchQuery = '';
  late final GetCategoriesUseCase _getCategoriesUseCase;
  late final GetProductsUseCase _getProductsUseCase;
  @override
  void initState() {
    super.initState();
    _getProductsUseCase = locator<GetProductsUseCase>();
    _getCategoriesUseCase = locator<GetCategoriesUseCase>();
    products = _getProductsUseCase.execute(widget.categoryId);
    category = fetchCategory(widget.categoryId);
  }

  Future<Category> fetchCategory(int categoryId) async {
    final categories = await _getCategoriesUseCase.execute();

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
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<Category>(
          future: category,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(kbuttoncolorColor),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                appLocale.error,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: textExtraLarge.sp,
                  color: kbuttoncolorColor,
                ),
              );
            } else {
              final category = snapshot.data!;
              return Text(
                category.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: textExtraLarge.sp,
                  color: kbuttoncolorColor,
                ),
              );
            }
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        children: [
          SearchWidget(
            hintText: appLocale.searchProduct,
            onChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('${appLocale.error} ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(appLocale.noProductsAvailable));
                } else {
                  final productList = snapshot.data!;
                  final filteredProducts = productList.where((product) {
                    final title = product.title.toLowerCase();
                    return title.contains(searchQuery.toLowerCase());
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return Center(
                        child: Text(appLocale.noProductsMatchYourSearch));
                  }

                  return GridView.builder(
                    padding: EdgeInsets.all(10.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7.w,
                      mainAxisSpacing: 7.h,
                      childAspectRatio: 0.54,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCardWidget(product: product);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
