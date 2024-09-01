import 'package:pcnc/extensions/sized_box_extension.dart';
import 'package:pcnc/helpers/navigator_helper.dart';
import 'package:pcnc/providers/lang_provider.dart';
import 'package:pcnc/util/font_sizes.dart';
import 'package:pcnc/widgets/profile_widgets/list_tile_item.dart';
import 'package:pcnc/widgets/profile_widgets/switch_theme_widget.dart';
import 'package:pcnc/util/theme.dart';
import 'package:pcnc/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pcnc/enums.dart';
import 'dart:ui';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with NavigatorHelper {
  AppLocalizations get appLocale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 790));
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<LanguageProvider>(
      builder: (context, lang, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              appLocale.profile,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: textExtraLarge.sp,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 30.0.h, top: 70.h),
              child: Padding(
                padding: EdgeInsets.all(20.0.dg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTileItem(
                            title: themeProvider.themeDataStyle ==
                                    ThemeDataStyle.dark
                                ? appLocale.darkMode
                                : appLocale.lightMode,
                            icon: themeProvider.themeDataStyle ==
                                    ThemeDataStyle.dark
                                ? Icons.nightlight_round
                                : Icons.wb_sunny,
                            toggle: SwitchThemeWidget(),
                            // Switch(
                            //   value: themeProvider.themeDataStyle ==
                            //       ThemeDataStyle.dark,
                            //   onChanged: (bool isOn) {
                            //     themeProvider.changeTheme();
                            //   },
                            //   activeColor: Theme.of(context)
                            //       .colorScheme
                            //       .onBackground,
                            //   inactiveTrackColor: kGrey2,
                            // ),
                          ),
                          20.height,
                          ListTileItem(
                            title: appLocale.language,
                            icon: Icons.language,
                            onTap: () => _showLanguages(lang),
                            toggle: Text(
                              lang.languageName(
                                  locale: AppLanguages.values
                                      .firstWhere((_) => _.name == lang.lang)),
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: textSmall.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        );
      },
    );
  }

  void _showLanguages(LanguageProvider lang) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: StatefulBuilder(
              builder: (context, newState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      30.height,
                      _buildLangItem(
                        AppLanguages.en,
                        newState,
                        lang,
                      ),
                      20.height,
                      _buildLangItem(
                        AppLanguages.ar,
                        newState,
                        lang,
                      ),
                      30.height,
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildLangItem(
    AppLanguages language,
    StateSetter newState,
    LanguageProvider lang,
  ) {
    return InkWell(
      onTap: () {
        lang.changeLang(language);
        context.popIt();
      },
      child: Row(
        children: [
          Icon(
            lang.lang == language.name
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: Theme.of(context).colorScheme.surface,
            size: 24.h,
          ),
          20.width,
          Text(
            lang.languageName(locale: language),
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontSize: textExtraLarge.sp,
            ),
          ),
        ],
      ),
    );
  }
}
