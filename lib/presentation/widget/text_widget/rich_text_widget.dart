import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/presentation/style/font_sizes.dart';

class RichTextWidget extends StatelessWidget {
  final String firstPart;
  final String interactiveText;
  final String secondPart;
  final VoidCallback? onInteractiveTextTap;

  const RichTextWidget({
    required this.firstPart,
    required this.interactiveText,
    required this.secondPart,
    this.onInteractiveTextTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstPart,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontSize: textMedium.sp,
            ),
        children: <TextSpan>[
          TextSpan(
            text: interactiveText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: kRed,
                  fontSize: textMedium.sp,
                  fontWeight: FontWeight.bold,
                ),
            recognizer: TapGestureRecognizer()..onTap = onInteractiveTextTap,
          ),
          TextSpan(
            text: secondPart,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: textMedium.sp,
                ),
          ),
        ],
      ),
    );
  }
}
