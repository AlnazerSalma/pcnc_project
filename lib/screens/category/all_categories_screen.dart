import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/screens/category/category_products_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/widgets/cards/category_card.dart';


class AllCategoriesScreen extends StatelessWidget {
  final List<dynamic> categories;

  AllCategoriesScreen({required this.categories});

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appLocale.categories,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: kbuttoncolorColor,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final categoryName = category['name'] ?? appLocale.unknownCategory;
            final categoryImage = category['image'];

            return CategoryCard(
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
    );
  }
}

