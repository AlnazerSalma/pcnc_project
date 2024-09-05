import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/aa/core/extension/sized_box_extension.dart';
import 'package:pcnc/aa/core/constant/font_sizes.dart';
import 'package:pcnc/aa/core/constant/color_palette.dart';
import 'package:pcnc/aa/features/product/domain/entity/product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ProductDetailsDialog extends StatelessWidget {
  final Product product;

  const ProductDetailsDialog({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
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
              if (product.images.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    product.images.first,
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
                product.title,
                style: TextStyle(
                  fontSize: textXExtraLarge.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.height,
              Text(
                product.description,
                style: TextStyle(
                  fontSize: textMedium.sp,
                ),
              ),
              10.height,
              Text(
                '\$${product.price}',
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
            appLocale.close,
            style: TextStyle(
              fontSize: textMedium.sp,
              color: kbuttoncolorColor,
            ),
          ),
        ),
      ],
    );
  }
}
