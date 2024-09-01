import 'package:flutter/material.dart';
import 'package:pcnc/drawer/main_drawer.dart';
import 'package:pcnc/screens/wishlist_screens/wishlist_screen.dart';
import 'package:pcnc/screens/home_screens/home_screen.dart';
import 'package:pcnc/screens/profile_screens/profile_screen.dart';
import 'package:pcnc/screens/settings_screens/settings_screen.dart';
import 'package:pcnc/providers/page_provider.dart';
import 'package:pcnc/screens/drawer_screens/menu_screen.dart';
import 'package:pcnc/screens/drawer_screens/selected_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ZoomDrawerAnimation extends StatefulWidget {
  const ZoomDrawerAnimation({super.key});

  @override
  State<ZoomDrawerAnimation> createState() => _ZoomDrawerAnimationState();
}

class _ZoomDrawerAnimationState extends State<ZoomDrawerAnimation>
    with SingleTickerProviderStateMixin {
  double drawerLength = 220;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> slideAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> borderAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    var curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(curve);
    rotationAnimation = Tween<double>(begin: 0, end: -0.15).animate(curve);
    slideAnimation = Tween<double>(begin: 0, end: drawerLength).animate(curve);
    borderAnimation = Tween<double>(begin: 0, end: 30).animate(curve);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocale = AppLocalizations.of(context)!;
    var textDirection = appLocale.localeName == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              MenuScreen(
                drawerLength: drawerLength,
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform(
                    alignment: textDirection == TextDirection.rtl
                        ? const Alignment(0.1, -0.1)
                        : const Alignment(0, -0.1),
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..scale(scaleAnimation.value)
                      ..translate(textDirection == TextDirection.rtl
                          ? -slideAnimation.value
                          : slideAnimation.value)
                      ..rotateZ(rotationAnimation.value),
                    child: MainScreen(
                      borderRadius: borderAnimation.value,
                      child: Consumer<PageProvider>(
                        builder: (context, state, child) {
                          return SelectedScreen(
                            content: getScreenForIndex(state.selectedIndex),
                            controller: controller,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return wishlistScreen();
      case 2:
        return SettingsScreen();
      case 3:
        return const ProfileScreen();
      default:
        return Container();
    }
  }
}
