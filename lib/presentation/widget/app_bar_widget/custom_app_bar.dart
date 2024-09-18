import 'package:flutter/material.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/presentation/widget/text_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar<T> extends StatelessWidget implements PreferredSizeWidget {
  final Future<T>? futureData;
  final String Function(T)? dataToString;
  final String? title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final Color? color;

  const CustomAppBar(
      {super.key,
      this.futureData,
      this.title,
      this.dataToString,
      this.backgroundColor,
      this.foregroundColor,
      this.centerTitle = true,
      this.color});

  @override
  Widget build(BuildContext context) {
     final appLocale = AppLocalizations.of(context)!;
    return AppBar(
      centerTitle: centerTitle,
      title: futureData != null
          ? FutureBuilder<T>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          color ?? Theme.of(context).colorScheme.surface),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return CustomText(
                    text: appLocale.error,
                  );
                } else {
                  final data = snapshot.data!;

                  return CustomText(
                    text:
                        dataToString != null ? dataToString!(data) : 'No title',
                  );
                }
              },
            )
          : CustomText(
              text: title ?? '',
              fontWeight: FontWeight.bold,
              fontSize: textExtraLarge.sp,
            ),
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.background,
      foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.surface,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
