import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/presentation/mixins/navigator_helper.dart';
import 'package:pcnc/presentation/drawer/provider/page_provider.dart';
import 'package:pcnc/presentation/style/color_palette.dart';
import 'package:pcnc/features/cart/presentation/screen/cart_screen.dart';
import 'package:pcnc/features/favorite/presentation/screen/favourite_screen.dart';
import 'package:pcnc/features/home/screen/home_screen.dart';
import 'package:pcnc/features/other_features/profile/presentation/screen/profile_screen.dart';
import 'package:pcnc/features/product/presentation/view/search_screen.dart';
import 'package:pcnc/features/other_features/settings/settings_screen.dart';
import 'package:pcnc/presentation/widget/bottom_nav_bar_widget.dart';
import 'package:pcnc/features/other_features/profile/presentation/widget/user_avatar_widget.dart';
import 'package:pcnc/generated/assets.dart';
import 'package:provider/provider.dart';

class SelectedScreen extends StatefulWidget with NavigatorHelper {
  const SelectedScreen({
    super.key,
    required this.controller,
    required Widget content,
  });

  final AnimationController controller;

  @override
  _SelectedScreenState createState() => _SelectedScreenState();
}

class _SelectedScreenState extends State<SelectedScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<PageProvider>().selectedIndex;
    final List<Widget> _screens = [
      HomeScreen(),
      FavouriteScreen(),
      SearchScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Theme.of(context).colorScheme.surface,
          onPressed: () {
            if (widget.controller.isCompleted) {
              widget.controller.reverse();
            } else {
              widget.controller.forward();
            }
          },
        ),
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.pcnc2,
                height: 40.h,
              ),
              Text(
                'pcnc',
                style: TextStyle(
                  color: Color(0xFFF89939),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: UserAvatarWidget(),
            color: kWhiteColor,
            iconSize: 24.sp,
            onPressed: () => widget.jumpTo(context, to: const ProfileScreen()),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: _screens[selectedIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => widget.jumpTo(context, to: CartScreen()),
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Theme.of(context).colorScheme.surface,
          size: 32.0,
        ),
        elevation: 0.0,
        shape: const CircleBorder(),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          context.read<PageProvider>().onTappedIndex(index);
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
