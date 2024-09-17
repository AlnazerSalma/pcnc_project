import 'package:flutter/material.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:pcnc/presentation/widget/app_bar_widget/custom_app_bar.dart';
import 'package:pcnc/features/cart/presentation/widget/cart_card_widget.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:pcnc/features/cart/presentation/provider/cart_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocale.cart,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;
          if (cartItems.isEmpty) {
            return Center(
              child: CustomText(
                text: appLocale.yourCartIsEmpty,
                fontSize: textExtraLarge,
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return CartCardWidget(
                      cartItem: cartItem,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: appLocale.totalPrice,
                      fontSize: textExtraLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                      fontSize: textExtraLarge,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
