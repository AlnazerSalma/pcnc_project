import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/features/product/presentation/widgets/card/product_card_widget.dart';
import 'package:pcnc/features/favorite/presentation/provider/favourite_provider.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/grid_view/custom_grid_view.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
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
              child:CustomText(text: appLocale.noFavoritesMessage, fontSize: textExtraLarge.sp,),
            )
          : CustomGridView(
              items: favoritesProvider.favorites,
              itemBuilder: (context, product) {
                return ProductCardWidget(product: product);
              },
            ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
