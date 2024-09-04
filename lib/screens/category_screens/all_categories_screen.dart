import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/screens/category_screens/category_products_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/aa/core/constant/color_palette.dart';
import 'package:pcnc/aa/core/constant/font_sizes.dart';
import 'package:pcnc/widgets/card_widgets/category_card_widget.dart';
import 'package:pcnc/widgets/search_widget.dart';

class AllCategoriesScreen extends StatefulWidget {
  final List<dynamic> categories;

  AllCategoriesScreen({required this.categories});

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final filteredCategories = widget.categories.where((category) {
      final name =
          (category['name'] ?? appLocale.unknownCategory).toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appLocale.categories,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textExtraLarge.sp,
            color: kbuttoncolorColor,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Column(
        children: [
          SearchWidget(
            hintText: appLocale.searchCategory,
            onChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  final categoryName =
                      category['name'] ?? appLocale.unknownCategory;
                  final categoryImage = category['image'];

                  return CategoryCardWidget(
                    name: categoryName,
                    imageUrl: categoryImage,
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
