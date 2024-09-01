import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/extensions/sized_box_extension.dart';
import 'package:pcnc/util/font_sizes.dart';

class CategoryCardWidget extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final VoidCallback onTap;

  CategoryCardWidget({
    required this.name,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.3),
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
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
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
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
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
              name,
              style: TextStyle(
                fontSize: textMedium.sp,
                fontWeight:FontWeight.bold,
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
