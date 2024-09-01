import 'package:flutter/material.dart';
import 'package:pcnc/util/font_sizes.dart';
import 'package:pcnc/widgets/card_widgets/cart_card_widget.dart';
import 'package:provider/provider.dart';
import 'package:pcnc/providers/cart_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appLocale.cart,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textExtraLarge.sp,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;

          if (cartItems.isEmpty) {
            return Center(
              child: Text(
                appLocale.yourCartIsEmpty,
                style: TextStyle(fontSize: textExtraLarge.sp),
              ),
            );
          }

          // Calculate total price
          final totalPrice = cartItems.fold<double>(0.0, (sum, item) {
            final price = double.tryParse(item['price']) ?? 0.0;
            final quantity = item['quantity'] ?? 1;
            return sum + (price * quantity);
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CartCardWidget(
                      id: item['id'],
                      title: item['title'],
                      price: item['price'],
                      description: item['description'],
                      imageUrl: item['images'].isNotEmpty ? item['images'].first : '',
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocale.totalPrice,
                      style: TextStyle(
                        fontSize: textExtraLarge.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: textExtraLarge.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
