import 'package:flutter/material.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final Color? color;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: textExtraLarge.sp,
          color: color ?? Theme.of(context).colorScheme.surface
        ),
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
      foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.surface,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
