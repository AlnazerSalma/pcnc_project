import 'package:pcnc/core/enum/app_languages.dart';
import 'package:pcnc/core/extension/sized_box_ext.dart';
import 'package:pcnc/core/extension/navigator_ext.dart';
import 'package:pcnc/core/presentation/mixins/navigator_helper.dart';
import 'package:pcnc/core/presentation/provider/theme_provider.dart';
import 'package:pcnc/core/presentation/provider/lang_provider.dart';
import 'package:pcnc/core/presentation/style/font_sizes.dart';
import 'package:pcnc/features/other_features/profile/presentation/widget/list_tile_item_widget.dart';
import 'package:pcnc/features/other_features/profile/presentation/widget/switch_theme_widget.dart';
import 'package:pcnc/core/presentation/style/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                          ListTileItemWidget(
                            title: themeProvider.themeDataStyle == AppTheme.dark
                                ? appLocale.darkMode
                                : appLocale.lightMode,
                            icon: themeProvider.themeDataStyle == AppTheme.dark
                                ? Icons.nightlight_round
                                : Icons.wb_sunny,
                            toggle: SwitchThemeWidget(),
                          ),
                          20.height,
                          ListTileItemWidget(
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
