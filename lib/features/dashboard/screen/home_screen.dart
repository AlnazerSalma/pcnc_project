import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/extension/sized_box_extension.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_use_case.dart';
import 'package:pcnc/features/category/presentation/screen/all_categories_screen.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_use_case.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/core/service/locator.dart';
import 'package:pcnc/features/product/presentation/view/category_products_screen.dart';
import 'package:pcnc/core/constant/color_palette.dart';
import 'package:pcnc/core/constant/font_sizes.dart';
import 'package:pcnc/features/dashboard/widget/show_all_button_widget.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Category>> categories;
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    final getCategoriesUseCase = locator<GetCategoriesUseCase>();
    categories = getCategoriesUseCase.execute();
    final getProductsUseCase = locator<GetProductsUseCase>();
    products = getProductsUseCase.getProducts();
  }

  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: Future.wait([categories, products]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${appLocale.error}  ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data![0].isEmpty ||
              snapshot.data![1].isEmpty) {
            return Center(child: Text(appLocale.noDataAvailable));
          } else {
            final categoryList = snapshot.data![0] as List<Category>;
            final productList = snapshot.data![1] as List<Product>;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.height,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocale.allCategories,
                          style: TextStyle(
                            fontSize: textXExtraLarge.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ShowAllButtonWidget(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllCategoriesScreen(
                                  getCategoriesUseCase:
                                      locator<GetCategoriesUseCase>(),
                                ),
                              ),
                            );
                          },
                          text: appLocale.showAll,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 170.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        final category = categoryList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryProductsScreen(
                                  categoryId: category.id,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width: 80.w,
                                    height: 80.h,
                                    child: category.image != null
                                        ? Image.network(
                                            category.image!,
                                            width: 80.w,
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: kRed,
                                                  size: 80.w,
                                                ),
                                              );
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            (loadingProgress
                                                                    .expectedTotalBytes ??
                                                                1)
                                                        : null,
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                        : Icon(Icons.category, size: 80.w),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  category.name,
                                  style: TextStyle(
                                    fontSize: textSmall.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7.w,
                      mainAxisSpacing: 7.h,
                      childAspectRatio: 0.54,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return ProductCardWidget(product: product);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
