import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pcnc/cache/cache_controller.dart';
import 'package:pcnc/extensions/sized_box_extension.dart';
import 'package:pcnc/providers/page_provider.dart';
import 'package:pcnc/screens/auth/auth.dart';
import 'package:pcnc/widgets/profile/UserAvatarDisplay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.drawerLength});
  final double drawerLength;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final appLocale = AppLocalizations.of(context)!;
    final Color backgroundColor = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          width: widget.drawerLength,
          color: backgroundColor,
          child: Column(
            children: [
              Container(
                height: 270,
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      20.height,
                      UserAvatarDisplay(),
                      10.height,
                      Text(
                        "name",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.surface,
                ),
                title: Text(
                  appLocale.home,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                onTap: () => context.read<PageProvider>().onTapSelectedIndex(0),
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.surface,
                ),
                title: Text(
                  appLocale.favorite,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                onTap: () => context.read<PageProvider>().onTapSelectedIndex(1),
              ),
              ListTile(
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.surface,
                ),
                title: Text(
                  appLocale.search,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                onTap: () => context.read<PageProvider>().onTapSelectedIndex(2),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.surface,
                ),
                title: Text(
                  appLocale.settings,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                onTap: () => context.read<PageProvider>().onTapSelectedIndex(3),
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.surface,
                ),
                title: Text(
                  appLocale.exit,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                onTap: () async {
                  await CacheController().logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
