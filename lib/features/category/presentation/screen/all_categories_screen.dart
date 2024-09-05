import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';
import 'package:pcnc/features/category/domain/usecases/get_categories_usecase.dart';
import 'package:pcnc/features/product/presentation/view/category_products_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/core/constant/color_palette.dart';
import 'package:pcnc/core/constant/font_sizes.dart';
import 'package:pcnc/features/category/presentation/widget/category_card_widget.dart';
import 'package:pcnc/features/product/presentation/widgets/search_widget.dart';

class AllCategoriesScreen extends StatefulWidget {
  final GetCategoriesUseCase getCategoriesUseCase;

  AllCategoriesScreen({required this.getCategoriesUseCase});

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  late Future<List<Category>> _categoriesFuture;
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    _categoriesFuture = widget.getCategoriesUseCase.execute();
  }

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
            fontSize: textExtraLarge.sp,
            color: kbuttoncolorColor,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body:FutureBuilder<List<Category>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('${appLocale.error} ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(appLocale.noCategoriesFound));
          } else {
            final filteredCategories = snapshot.data!.where((category) {
              return category.name
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase());
            }).toList();

            return Column(
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

                        return CategoryCardWidget(
                          category: category,
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}