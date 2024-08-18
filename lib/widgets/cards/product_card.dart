import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/util/color_palette.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final List<String> images;

  ProductCard({
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
                  fontSize: 14.sp,
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
                  fontSize: 12.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                '\$${price}',
                style: TextStyle(
                  fontSize: 18.sp,
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
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).colorScheme.surface,
                          size: 20.dg,
                        ),
                        onPressed: () {},
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
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(context).colorScheme.surface,
                      size: 20.dg,
                    ),
                    onPressed: () {},
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
                  SizedBox(height: 10.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    '\$${price}',
                    style: TextStyle(
                      fontSize: 22.sp,
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
                  fontSize: 16.sp,
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
                    // Blurred background
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color: Colors.black
                              .withOpacity(0.5), // Semi-transparent overlay
                        ),
                      ),
                    ),
                    // Error message
                    Center(
                      child: Text(
                        'Error loading image',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.sp,
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
                      // Blurred background
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            color: Colors.black
                                .withOpacity(0.5), // Semi-transparent overlay
                          ),
                        ),
                      ),
                      // Image
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
