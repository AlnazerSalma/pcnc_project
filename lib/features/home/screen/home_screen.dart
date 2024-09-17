import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/application_manager/navigation_manager.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/features/category/domain/manager/category_manager.dart';
import 'package:pcnc/features/product/domain/manager/product_data_manager.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:pcnc/features/category/presentation/screen/all_categories_screen.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/domain/usecase/get_products_usecase.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/data/service/locator.dart';
import 'package:pcnc/features/product/presentation/view/category_products_screen.dart';
import 'package:pcnc/features/home/widget/show_all_button_widget.dart';
import 'package:pcnc/presentation/widget/grid_view/custom_grid_view.dart';
import 'package:pcnc/presentation/widget/images/card_image.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CategoryDataManager _categoryDataManager;
  late ProductDataManager _productDataManager;

  @override
  void initState() {
    super.initState();
    final getCategoriesUseCase = locator<GetCategoriesUseCase>();

    _categoryDataManager =
        CategoryDataManager(fetchData: getCategoriesUseCase.execute);
    final getProductsUseCase = locator<GetProductsUseCase>();
    _productDataManager = ProductDataManager(getProductsUseCase);
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _categoryDataManager.loadData(),
      _productDataManager.loadData(),
    ]);
    // Update the UI after data is loaded
    setState(() {});
  }

  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    final navigationManager = NavigationManager(context);
    ScreenUtil.init(context, designSize: Size(375, 790));
    if (_categoryDataManager.isLoading || _productDataManager.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    final categoryList = _categoryDataManager.data ?? [];
    final productList = _productDataManager.data ?? [];
    if (categoryList.isEmpty || productList.isEmpty) {
      return Center(child: Text(appLocale.noDataAvailable));
    }
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
                CustomText(
                  text: appLocale.allCategories,
                  fontSize: textXExtraLarge.sp,
                  fontWeight: FontWeight.bold,
                ),
                ShowAllButtonWidget(
                  onPressed: () {
                    navigationManager.navigateTo(
                      AllCategoriesScreen(
                        getCategoriesUseCase: locator<GetCategoriesUseCase>(),
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
                    navigationManager.navigateTo(
                      CategoryProductsScreen(
                        categoryId: category.id,
                      ),
                    );
                  },
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        category.image != null
                            ? CardImage(
                                imageUrl: category.image!,
                                width: 80.h,
                                height: 80.h,
                                errorImage: Assets.imageNotAvailable,
                              )
                            : SizedBox(width: 80.h, height: 80.h),
                        8.height,
                        CustomText(
                          text: category.name,
                          fontSize: textSmall,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 400.h,
            child: CustomGridView<Product>(
              items: productList,
              itemBuilder: (context, product) =>
                  ProductCardWidget(product: product),
              crossAxisCount: 2,
              crossAxisSpacing: 7.w,
              mainAxisSpacing: 7.h,
              childAspectRatio: 0.54,
            ),
          ),
        ],
      ),
    );
  }
}
