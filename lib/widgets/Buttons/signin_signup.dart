import 'package:pcnc/util/color_palette.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final double fontSize;

  const CustomButton({
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.height = 50.0,
    this.color = const Color(0xFFF89939),
    this.textColor = kWhiteColor,
    this.fontSize = 18.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                    ),
              ),
            ),
            Transform(
              transform: Matrix4.identity()..rotateZ(3.14),
              child: Container(
                width: 30.0,
                height: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
