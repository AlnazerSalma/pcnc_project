import 'package:flutter/material.dart';
import 'package:pcnc/widgets/cards/cart_item_card.dart';
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
            fontSize: 18.sp,
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
                style: TextStyle(fontSize: 18.sp),
              ),
            );
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return CartItemCard(
                id: item['id'],
                title: item['title'],
                price: item['price'],
                description: item['description'],
                imageUrl: item['images'].isNotEmpty ? item['images'].first : '',
              );
            },
          );
        },
      ),
    );
  }
}

