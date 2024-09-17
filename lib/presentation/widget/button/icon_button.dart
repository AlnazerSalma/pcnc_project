import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double? iconSize;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? radius;

  const CustomIconButton({
    required this.icon,
    required this.iconColor,
    this.iconSize,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(
      icon,
      color: iconColor,
      size: iconSize?.dg ?? 16.dg,
    );

    if (backgroundColor != null && radius != null) {
      iconWidget = CircleAvatar(
        radius: radius!.w,
        backgroundColor: backgroundColor,
        child: iconWidget,
      );
    }

    return IconButton(
      icon: iconWidget,
      onPressed: onPressed,
    );
  }
}
