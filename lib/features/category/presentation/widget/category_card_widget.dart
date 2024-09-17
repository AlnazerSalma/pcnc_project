import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/core/constant/font_sizes.dart';
import 'package:pcnc/features/category/domain/entity/category.dart';

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
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: SizedBox(
                width: double.infinity,
                height: 140.h,
                child: category.image != null
                    ? Image.network(
                        category.image!,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50.w,
                            ),
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
                      )
                    : Icon(Icons.category, size: 100.w),
              ),
            ),
            8.height,
            Text(
              category.name,
              style: TextStyle(
                fontSize: textMedium.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
