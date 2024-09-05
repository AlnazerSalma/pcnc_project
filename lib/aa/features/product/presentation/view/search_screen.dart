import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/ApiService/api_service.dart';
import 'package:pcnc/aa/core/extension/sized_box_extension.dart';
import 'package:pcnc/aa/core/constant/font_sizes.dart';
import 'package:pcnc/aa/features/product/presentation/widgets/search_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/aa/features/product/presentation/widgets/card/product_card_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  late Future<List<dynamic>> products;
  List<dynamic> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    products = ApiService().getProducts();
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      if (searchQuery.isEmpty) {
        filteredProducts = [];
      } else {
        products.then((allProducts) {
          filteredProducts = allProducts.where((product) {
            final title = (product['title'] ?? '').toLowerCase();
            return title.contains(searchQuery);
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;

    return Column(
      children: [
        SearchWidget(
          hintText: appLocale.searchProduct,
          onChanged: _filterProducts,
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (filteredProducts.isEmpty && searchQuery.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/noResultFound.png',
                          fit: BoxFit.fill,
                          height: 200.h,
                        ),
                        10.height,
                        Center(
                          child: Text(
                            appLocale.noProductFoundWithThisName,
                            style: TextStyle(
                              fontSize: textMedium.sp,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.all(8.0),
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
              }
            },
          ),
        ),
      ],
    );
  }
}
