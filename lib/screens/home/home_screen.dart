import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/ApiService/api_service.dart';
import 'package:pcnc/screens/category/all_categories_screen.dart';
import 'package:pcnc/screens/category/category_products_screen.dart';
import 'package:pcnc/widgets/cards/product_card.dart';
import 'package:pcnc/widgets/customButton.dart';
import 'package:pcnc/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> categories;
  late Future<List<dynamic>> products;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    categories = ApiService().getCategories();
    products = ApiService().getProducts(offset: 0, limit: 10);
  }

  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([categories, products]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data![0].isEmpty ||
              snapshot.data![1].isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final categoryList = snapshot.data![0] as List<dynamic>;
            final productList = snapshot.data![1] as List<dynamic>;
            final filteredCategories = categoryList.where((category) {
              if (category is Map<String, dynamic>) {
                final name = category['name']?.toLowerCase() ?? '';
                final query = searchQuery.toLowerCase();
                return name.contains(query);
              }
              return false;
            }).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchWidget(
                    hintText: appLocale.searchProduct,
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocale.allCategories,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllCategoriesScreen(
                                  categories: categoryList,
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
                    height: 160.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final category =
                            filteredCategories[index] as Map<String, dynamic>;
                        final categoryName = category['name'] ?? 'Unknown';
                        final categoryImage = category['image'];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryProductsScreen(
                                  categoryId: category['id'],
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
                                    child: categoryImage != null
                                        ? Image.network(
                                            categoryImage,
                                            width: 80.w,
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.red,
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
                                  categoryName,
                                  style: TextStyle(
                                    fontSize: 12.sp,
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
                      final product =
                          productList[index] as Map<String, dynamic>;
                      return ProductCard(
                        title: product['title'] ?? 'No Title',
                        price: product['price']?.toString() ?? '0.00',
                        description: product['description'] ?? 'No Description',
                        images: List<String>.from(product['images'] ?? []),
                      );
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
