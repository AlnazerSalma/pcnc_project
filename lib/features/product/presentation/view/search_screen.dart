import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/presentation/style/font_sizes.dart';
import 'package:pcnc/core/service/locator.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';
import 'package:pcnc/features/product/presentation/widgets/search_widget.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/generated/assets.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  late Future<List<Product>> products;
  String searchQuery = '';
  late final GetProductsUseCase _getProductsUseCase;

  @override
  void initState() {
    super.initState();
    _getProductsUseCase = locator<GetProductsUseCase>();
    products = _getProductsUseCase.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));

    return Scaffold(
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
                  return Center(
                      child: Text('${appLocale.error} ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.noResultFound,
                          fit: BoxFit.fill,
                          height: 200.h,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          appLocale.noProductFoundWithThisName,
                          style: TextStyle(
                            fontSize: textMedium.sp,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  final productList = snapshot.data!;
                  if (searchQuery.isEmpty) {
                    return Center(
                      child: Image.asset(
                        Assets.noResultFound,
                        fit: BoxFit.fill,
                        height: 200.h,
                      ),
                    );
                  }

                  final filteredProducts = productList.where((product) {
                    final title = product.title.toLowerCase();
                    return title.contains(searchQuery.toLowerCase());
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.noResultFound,
                            fit: BoxFit.fill,
                            height: 200.h,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            appLocale.noProductFoundWithThisName,
                            style: TextStyle(
                              fontSize: textMedium.sp,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                    );
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
