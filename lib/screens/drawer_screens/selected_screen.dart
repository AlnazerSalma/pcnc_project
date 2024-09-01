import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/screens/cart_screens/cart_screen.dart';
import 'package:pcnc/screens/wishlist_screens/wishlist_screen.dart';
import 'package:pcnc/screens/home_screens/home_screen.dart';
import 'package:pcnc/screens/profile_screens/profile_screen.dart';
import 'package:pcnc/screens/search_screens/search_screen.dart';
import 'package:pcnc/screens/settings_screens/settings_screen.dart';
import 'package:pcnc/util/color_palette.dart';
import 'package:pcnc/widgets/bottom_nav_bar_widget.dart';
import 'package:pcnc/widgets/profile_widgets/user_avatar.dart';
import 'package:pcnc/helpers/navigator_helper.dart';
import 'package:provider/provider.dart';
import 'package:pcnc/providers/page_provider.dart';

class SelectedScreen extends StatefulWidget with NavigatorHelper {
  const SelectedScreen({
    super.key,
    required this.controller, required Widget content,
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
      wishlistScreen(),
      SearchScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
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
                'assets/images/pcnc2.png',
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
            icon: UserAvatar(),
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
    );
  }
}
