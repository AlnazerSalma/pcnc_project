import 'package:pcnc/cache/cache_controller.dart';
import 'package:pcnc/enums.dart';
import 'package:pcnc/helpers/restart_app.dart';
import 'package:pcnc/providers/lang_provider.dart';
import 'package:pcnc/providers/page_provider.dart';
import 'package:pcnc/screens/splash.dart';
import 'package:pcnc/util/theme.dart';
import 'package:pcnc/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/provider.dart' as provider;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheController().initSharedPreferences();
  String? theme = CacheController().getter(key: CacheKeys.theme);
  ThemeData initialThemeMode =
      theme == 'dark' ? ThemeDataStyle.dark : ThemeDataStyle.light;

  runApp(
    provider.ChangeNotifierProvider(
      create: (context) => ThemeProvider(initialThemeMode),
      child: riverpod.ProviderScope(child: App()),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => _updateTheme());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _updateTheme() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    provider.Provider.of<ThemeProvider>(context, listen: false)
        .updateTheme(isDarkMode);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _updateTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414.0, 896.0),
      builder: (context, child) {
        return RestartApp(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => LanguageProvider()),
              ChangeNotifierProvider(create: (context) => PageProvider()),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  title: 'Drago',
                  debugShowCheckedModeBanner: false,
                  theme: themeProvider.themeDataStyle,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLanguages.values
                      .map((language) => Locale(language.name))
                      .toList(),
                  locale: Locale(Provider.of<LanguageProvider>(context).lang),
                  home: const SplashScreen(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}



