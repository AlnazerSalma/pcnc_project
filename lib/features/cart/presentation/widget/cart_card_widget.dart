import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/features/cart/data/model/cart_model.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/button/icon_button.dart';
import 'package:pcnc/presentation/widget/images/card_image.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
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
                  ? CardImage(
                      imageUrl: cartItem.imageUrl,
                      width: 80,
                      height: 100,
                      errorImage: Assets.imageNotAvailable,
                      isCircular: true,
                    )
                  : SizedBox(width: 80.w, height: 100.h),
              8.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: cartItem.title,
                      fontWeight: FontWeight.bold,
                      fontSize: textmMedium,
                      overflow: TextOverflow.visible,
                    ),
                    Spacer(),
                    CustomText(
                      text: '\$${cartItem.price}',
                      color: klightblueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: textExtraLarge,
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
                      CustomIconButton(
                        icon: Icons.remove,
                        iconColor: kWhiteColor,
                        backgroundColor: kRed,
                        radius: 14,
                        onPressed: () {
                          cartProvider.updateQuantity(cartItem.id, false);
                        },
                      ),
                      4.width,
                      CustomText(text: '${cartItem.quantity}'),
                      4.width,
                      CustomIconButton(
                        icon: Icons.add,
                        iconColor: kWhiteColor,
                        backgroundColor: kgreen,
                        radius: 14,
                        onPressed: () {
                          cartProvider.updateQuantity(cartItem.id, true);
                        },
                      ),
                    ],
                  ),
                  5.height,
                  CustomIconButton(
                    icon: Icons.delete,
                    iconColor: kRed,
                    iconSize: 22,
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
