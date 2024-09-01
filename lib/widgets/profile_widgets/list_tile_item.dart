import 'package:pcnc/extensions/sized_box_extension.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/util/font_sizes.dart';

class ListTileItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  final Widget? toggle;

  const ListTileItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.toggle,
    super.key,
  });

  @override
  State<ListTileItem> createState() => _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      height: 61.h,
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.all(8.0.dg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.surface,
                size: 20.dm,
              ),
              10.width,
              Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: textMedium.sp,
                ),
              ),
              const Spacer(),
              widget.toggle ?? empty,
            ],
          ),
        ),
      ),
    );
  }
}
