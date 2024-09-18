
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/data/service/locator.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/manager/product_data_manager.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';
import 'package:pcnc/presentation/widget/search_widget.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:pcnc/presentation/widget/grid_view/custom_grid_view.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  late ProductDataManager _productDataManager;
  String searchQuery = '';
  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    final getProductsUseCase = locator<GetProductsUseCase>();
    _productDataManager = ProductDataManager(getProductsUseCase);
    productsFuture = _productDataManager.fetchData();
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
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: CustomText(text: '${appLocale.error} ${snapshot.error}'));
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
                        10.height,
                        CustomText(text: appLocale.noProductFoundWithThisName),
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
                          CustomText(text: appLocale.noProductFoundWithThisName),
                        ],
                      ),
                    );
                  }

                  return CustomGridView<Product>(
                    items: filteredProducts,
                    itemBuilder: (context, product) => ProductCardWidget(product: product),
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
