import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  static late AppLocalizations instance;

  final Locale locale;

  AppLocalizations(this.locale, this.translations);

  static Future<AppLocalizations> load(Locale locale) async {
    final jsonString = await rootBundle.loadString('locales/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    return AppLocalizations._(locale, jsonMap);
  }

  final Map<String, dynamic> translations;

  AppLocalizations._(this.locale, this.translations);

  String translate(String key) {
    return translations[key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'tr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
