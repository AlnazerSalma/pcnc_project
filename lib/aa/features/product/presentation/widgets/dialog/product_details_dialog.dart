import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/aa/core/extension/sized_box_extension.dart';
import 'package:pcnc/aa/core/constant/font_sizes.dart';
import 'package:pcnc/aa/core/constant/color_palette.dart';

class ProductDetailsDialog extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final List<String> images;

  const ProductDetailsDialog({
    required this.title,
    required this.description,
    required this.price,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}
