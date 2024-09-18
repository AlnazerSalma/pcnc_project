import 'package:pcnc/core/enum/e_app_languages.dart';
import 'package:pcnc/presentation/controller/cache_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/enum/e_cache_keys.dart';

class LanguageProvider extends ChangeNotifier {
  String lang = CacheController().getter(key: CacheKeys.language) ?? 'en';

  String languageName({AppLanguages? locale}) {
    String _ = locale?.name ?? lang;
    switch (_) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
    }

    return '';
  }

  bool appDirectionRtl = true;

  Future<void> changeLang(AppLanguages language) async {
    lang = language.name;
    switch (language) {
      case AppLanguages.ar:
        appDirectionRtl = true;
        break;
      case AppLanguages.en:
        appDirectionRtl = false;
        break;
    }

    await CacheController().setter(
      key: CacheKeys.language,
      value: lang,
    );
    notifyListeners();
  }

  Future<void> changeLangLocale(String language) async {
    lang = language;
    switch (language) {
      case 'ar':
        appDirectionRtl = true;
        break;
      case 'en':
        appDirectionRtl = false;
        break;
    }
    await CacheController().setter(
      key: CacheKeys.language,
      value: lang,
    );
    notifyListeners();
  }
}
