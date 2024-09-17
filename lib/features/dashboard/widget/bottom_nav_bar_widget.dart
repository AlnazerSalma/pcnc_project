import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/core/presentation/style/color_palette.dart';
import 'package:pcnc/core/presentation/style/font_sizes.dart';


class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNavItem(context, Icons.home, appLocale.homelabel, 0),
            _buildNavItem(
                context, Icons.favorite_outlined, appLocale.favorite, 1),
            48.width,
            _buildNavItem(context, Icons.search, appLocale.search, 2),
            _buildNavItem(context, Icons.settings, appLocale.settings, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, int index) {
    final isSelected = widget.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        widget.onItemSelected(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: isSelected ? kRed : kWhiteColor,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: textTiny.sp,
              color: isSelected ? kRed : kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
