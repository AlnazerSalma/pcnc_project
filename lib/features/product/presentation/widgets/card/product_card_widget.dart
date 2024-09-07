import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:pcnc/features/product/domain/entity/product.dart';
import 'package:pcnc/features/product/presentation/widgets/dialog/full_image_dialog.dart';
import 'package:pcnc/features/product/presentation/widgets/dialog/product_details_dialog.dart';
import 'package:pcnc/features/cart/presentation/provider/cart_provider.dart';
import 'package:pcnc/features/product/presentation/provider/favourite_provider.dart';
import 'package:pcnc/core/constant/color_palette.dart';
import 'package:pcnc/core/constant/font_sizes.dart';
import 'package:provider/provider.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;

  ProductCardWidget({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ProductDetailsDialog(
            product: product,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .onInverseSurface
                  .withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images.isNotEmpty)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        FullImageDialog(imageUrl: product.images.first),
                  );
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: Image.network(
                    product.images.first,
                    width: double.infinity,
                    height: 120.h,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/image-not-available.png',
                        width: double.infinity,
                        height: 120.h,
                        fit: BoxFit.fill,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(7.w),
              child: Text(
                product.title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: textMedium.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.w),
              child: Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: textSmall.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                '\$${product.price}',
                style: TextStyle(
                  fontSize: textExtraLarge.sp,
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Consumer<FavouriteProvider>(
                        builder: (context, wishListProvider, child) {
                          final isFavorite =
                              wishListProvider.isFavorite(product.id);
                          return IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? kRed
                                  : Theme.of(context).colorScheme.surface,
                              size: 20.w,
                            ),
                            onPressed: () {
                              wishListProvider.toggleFavorite(product);
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.bookmark_border,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20.dg,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      final isInCart = cartProvider.isInCart(product.id);
                      return IconButton(
                        icon: Icon(
                          isInCart
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          color: isInCart
                              ? kblueColor
                              : Theme.of(context).colorScheme.surface,
                          size: 20.w,
                        ),
                        onPressed: () {
                          if (isInCart) {
                            cartProvider.removeFromCart(product.id);
                          } else {
                            cartProvider.addToCart(
                              CartItemModel.fromProduct(product),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
