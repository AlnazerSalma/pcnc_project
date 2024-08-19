import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:provider/provider.dart';
import 'package:pcnc/providers/cart_provider.dart';

class CartItemCard extends StatelessWidget {
  final int id;
  final String title;
  final String price;
  final String description;
  final String imageUrl;

  CartItemCard({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cardRadius = 8.0; 

    return Card(
      margin: EdgeInsets.all(10.w),
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius), 
      ),
      child: ListTile(
        leading: imageUrl.isNotEmpty
            ? ClipOval(
                child: Image.network(
                  imageUrl,
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
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                ),
              )
            : SizedBox(width: 80.w, height: 80.h), 
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        subtitle: Text(
          '\$${price}',
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: kRed),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .removeFromCart(id);
          },
        ),
      ),
    );
  }
}
