import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/providers/wishlist_provider.dart';
import 'package:pcnc/aa/core/constant/color_palette.dart';
import 'package:pcnc/widgets/card_widgets/product_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class wishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final favoritesProvider = Provider.of<WishListProvider>(context);

    return Scaffold(
      body: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 7.w,
          mainAxisSpacing: 7.h,
          childAspectRatio: 0.54,
        ),
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          final product = favoritesProvider.favorites[index];
          return ProductCardWidget(
            id: product['id'],
            title: product['title'],
            price: product['price'],
            description: product['description'],
            images: product['images'],
          );
        },
      ),
    );
  }
}
