import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/presentation/style/color_palette.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final double? width;
  final double? height; 

  const CircleButton({
    required this.onPressed,
    required this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidth = width ?? 50.0.w;
    final buttonHeight = height ?? 50.0.h;

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: kbuttoncolorColor.withOpacity(0.8),
            spreadRadius: 5.r,
            blurRadius: 7.r,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: icon,
      ),
    );
  }
}
