import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/features/product/presentation/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final favoritesProvider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      body: favoritesProvider.favorites.isEmpty
          ? Center(
              child: Text(
                appLocale.noFavoritesMessage,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            )
          : GridView.builder(
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
                return ProductCardWidget(product: product);
              },
            ),
    );
  }
}
