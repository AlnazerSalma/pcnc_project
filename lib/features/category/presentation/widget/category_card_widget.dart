import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';
import 'package:pcnc/presentation/widget/images/card_image.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';

class CategoryCardWidget extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  CategoryCardWidget({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.r),
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
          children: [
            CardImage(
              imageUrl: category.image!,
              width: double.infinity,
              height: 135.h,
              errorImage: Assets.imageNotAvailable,
              isCircular: false,
            ),
            8.height,
            CustomText(
                text: category.name,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
