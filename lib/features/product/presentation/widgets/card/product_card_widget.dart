import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/application_manager/dialog_manager.dart';
import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/presentation/dialog/image_dialog.dart';
import 'package:pcnc/features/product/presentation/widgets/dialog/product_details_dialog.dart';
import 'package:pcnc/features/cart/presentation/provider/cart_provider.dart';
import 'package:pcnc/features/favorite/presentation/provider/favourite_provider.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/button/icon_button.dart';
import 'package:pcnc/presentation/widget/card/base_card_widget.dart';
import 'package:pcnc/presentation/widget/images/card_image.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
import 'package:provider/provider.dart';

class ProductCardWidget extends BaseCardWidget {
  final Product product;

  const ProductCardWidget({
    required this.product,
  });

  @override
  void onCardTap(BuildContext context) {
    DialogManager.showDialogWidget(
      context,
      ProductDetailsDialog(product: product),
    );
  }

  @override
  Widget buildImage(BuildContext context) {
    return product.images.isNotEmpty
        ? GestureDetector(
            onTap: () {
              DialogManager.showDialogWidget(
                context,
                ImageDialog(imageUrl: product.images.first),
              );
            },
            child: CardImage(
              imageUrl: product.images.first,
              width: double.infinity,
              height: 135.h,
              errorImage: Assets.imageNotAvailable,
              isCircular: false,
            ),
          )
        : SizedBox.shrink();
  }

  @override
  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.w),
      child: CustomText(
        text: product.title,
        maxLines: 1,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget buildDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.w),
      child: CustomText(
        text: product.description,
        fontSize: textSmall.sp,
        maxLines: 2,
      ),
    );
  }

  @override
  Widget buildPrice(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: CustomText(
        text: '\$${product.price}',
        fontWeight: FontWeight.bold,
        fontSize: textExtraLarge,
      ),
    );
  }

  @override
  Widget buildActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Consumer<FavouriteProvider>(
                builder: (context, wishListProvider, child) {
                  final isFavorite = wishListProvider.isFavorite(product.id);
                  return CustomIconButton(
                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                    iconColor: isFavorite
                        ? kRed
                        : Theme.of(context).colorScheme.surface,
                    iconSize: 18.dm,
                    onPressed: () {
                      wishListProvider.toggleFavorite(product);
                    },
                  );
                },
              ),
              CustomIconButton(
                icon: Icons.bookmark_border,
                iconColor: Theme.of(context).colorScheme.surface,
                iconSize: 18.dm,
                onPressed: () {},
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              final isInCart = cartProvider.isInCart(product.id);
              return CustomIconButton(
                icon: isInCart
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                iconColor: isInCart
                    ? kbuttoncolorColor
                    : Theme.of(context).colorScheme.surface,
                iconSize: 18.dm,
                onPressed: () {
                  if (isInCart) {
                    cartProvider.removeFromCart(product.id);
                  } else {
                    cartProvider.addToCart(CartItemModel.fromProduct(product));
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
