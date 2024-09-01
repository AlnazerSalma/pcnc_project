import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/util/font_sizes.dart';
import 'package:pcnc/widgets/card_widgets/product_card_widget.dart';
import 'package:pcnc/widgets/search_widget.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;

  CategoryProductsScreen({required this.categoryId});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;
  late Future<List<dynamic>> products;
  late Future<String> categoryName;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    products = fetchProducts(widget.categoryId);
    categoryName = fetchCategoryName(widget.categoryId);
  }

  Future<String> fetchCategoryName(int categoryId) async {
    final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/categories/$categoryId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['name'] ?? 'Unknown Category';
    } else {
      throw Exception('Failed to load category');
    }
  }

  Future<List<dynamic>> fetchProducts(int categoryId) async {
    final response = await http.get(Uri.parse(
        'https://api.escuelajs.co/api/v1/categories/$categoryId/products'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<String>(
          future: categoryName,
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
                'Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: textExtraLarge.sp,
                  color: kbuttoncolorColor,
                ),
              );
            } else {
              return Text(
                snapshot.data ?? 'Unknown Category',
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
            child: FutureBuilder<List<dynamic>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products available'));
                } else {
                  final productList = snapshot.data!;

                  // Filter products based on search query
                  final filteredProducts = productList.where((product) {
                    final title = product['title']?.toLowerCase() ?? '';
                    return title.contains(searchQuery.toLowerCase());
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return Center(
                        child: Text('No products match your search.'));
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
                      final productId = product['id'] ?? 0;
                      final productTitle = product['title'] ?? 'Unknown';
                      final productPrice =
                          product['price']?.toString() ?? '0.0';
                      final productDescription =
                          product['description'] ?? 'No description available';
                      final productImages =
                          List<String>.from(product['images'] ?? []);

                      return ProductCardWidget(
                        id: productId,
                        title: productTitle,
                        price: productPrice,
                        description: productDescription,
                        images: productImages,
                      );
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
