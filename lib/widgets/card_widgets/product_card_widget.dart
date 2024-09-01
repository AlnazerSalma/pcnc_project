import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/extensions/sized_box_extension.dart';
import 'package:pcnc/providers/cart_provider.dart';
import 'package:pcnc/providers/favorites_provider.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/util/font_sizes.dart';
import 'package:provider/provider.dart';

class ProductCardWidget extends StatelessWidget {
  final int id;
  final String title;
  final String price;
  final String description;
  final List<String> images;

  ProductCardWidget({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showProductDetailsDialog(context);
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
            if (images.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _showFullImage(context, images.first);
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: Image.network(
                    images.first,
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
                title,
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
                description,
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
                '\$${price}',
                style: TextStyle(
                  fontSize: textExtraLarge.sp,
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Consumer<FavoritesProvider>(
                        builder: (context, favoritesProvider, child) {
                          final isFavorite = favoritesProvider.isFavorite(id);
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
                              favoritesProvider.toggleFavorite({
                                'id': id,
                                'title': title,
                                'price': price,
                                'description': description,
                                'images': images,
                              });
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
                      final isInCart = cartProvider.isInCart(id);

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
                            cartProvider.removeFromCart(id);
                          } else {
                            cartProvider.addToCart({
                              'id': id,
                              'title': title,
                              'price': price,
                              'description': description,
                              'images': images,
                            });
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

  void _showProductDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0.r),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9.w,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (images.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        images.first,
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/image-not-available.png',
                            width: double.infinity,
                            height: 200.h,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  10.height,
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: textXExtraLarge.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.height,
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: textMedium.sp,
                    ),
                  ),
                  10.height,
                  Text(
                    '\$${price}',
                    style: TextStyle(
                      fontSize: textXExtraLarge.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontSize: textMedium.sp,
                  color: kbuttoncolorColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(0),
          backgroundColor: Colors.transparent,
          child: FutureBuilder(
            future: _getImageSize(imageUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Error loading image',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: textExtraLarge.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                final imageSize = snapshot.data as Size?;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Center(
                        child: Image.network(
                          imageUrl,
                          width: imageSize?.width ?? double.infinity,
                          height: imageSize?.height ?? double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Future<Size?> _getImageSize(String imageUrl) async {
    final Completer<Size> completer = Completer();
    final Image image = Image.network(imageUrl);
    image.image.resolve(ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool synchronousCall) {
              completer.complete(Size(
                info.image.width.toDouble(),
                info.image.height.toDouble(),
              ));
            },
            onError: (dynamic error, StackTrace? stackTrace) {
              completer.completeError(error);
            },
          ),
        );
    return completer.future;
  }
}
