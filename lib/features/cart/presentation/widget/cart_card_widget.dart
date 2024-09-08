import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/extension/sized_box_extension.dart';
import 'package:pcnc/core/constant/color_palette.dart';
import 'package:pcnc/core/constant/font_sizes.dart';
import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:pcnc/features/cart/presentation/provider/cart_provider.dart';

class CartCardWidget extends StatelessWidget {
  final CartItemModel cartItem;

  CartCardWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cardRadius = 8.0;
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: Container(
          padding: EdgeInsets.all(8.w),
          height: 120.h,
          child: Row(
            children: [
              cartItem.imageUrl.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        cartItem.imageUrl,
                        width: 80.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/image-not-available.png',
                            width: 80.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                      ),
                    )
                  : SizedBox(width: 80.w, height: 100.h),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.title,
                      style: TextStyle(
                        fontSize: textMedium.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                    Text(
                      '\$${cartItem.price}',
                      style: TextStyle(
                        fontSize: textMedium.sp,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: CircleAvatar(
                          radius: 14.w,
                          backgroundColor: kRed,
                          child: Icon(Icons.remove,
                              color: kWhiteColor, size: 16.sp),
                        ),
                        onPressed: () {
                          cartProvider.updateQuantity(cartItem.id, false);
                        },
                      ),
                      4.width,
                      Text(
                        '${cartItem.quantity}',
                        style: TextStyle(
                            fontSize: textMedium.sp,
                            color: Theme.of(context).colorScheme.surface),
                      ),
                      4.width,
                      IconButton(
                        icon: CircleAvatar(
                          radius: 14.w,
                          backgroundColor: kgreen,
                          child:
                              Icon(Icons.add, color: kWhiteColor, size: 16.sp),
                        ),
                        onPressed: () {
                          cartProvider.updateQuantity(cartItem.id, true);
                        },
                      ),
                    ],
                  ),
                  5.height,
                  IconButton(
                    icon: Icon(Icons.delete, color: kRed),
                    onPressed: () {
                      cartProvider.removeFromCart(cartItem.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
