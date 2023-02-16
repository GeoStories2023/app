import 'package:flutter/material.dart';

import '../preferences/iprefs.dart';
import '../preferences/prefs_factory.dart';

enum Units {
  metric,
  imperial,
}

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  IPrefs? prefs;
  Units? _unit;

  Units get unit => _unit ?? Units.metric;

  Locale get locale => _locale ?? const Locale("en", "");

  LocaleProvider() {
    readLocale();
  }

  Future<void> readLocale() async {
    prefs = PrefsFactory().prefs;
    await prefs?.init();
    String? localeStr = prefs?.getString("locale");

    if (localeStr != null) {
      _locale = Locale(localeStr, "");
    } else {
      _locale = const Locale("en", "");
    }
  }

  Future<void> readUnit() async {
    prefs = PrefsFactory().prefs;
    await prefs?.init();
    String? unitStr = prefs?.getString("unit");

    if (unitStr == "imperial") {
      _unit = Units.imperial;
    } else {
      _unit = Units.metric;
    }
  }

  void setLocale(Locale locale) async {
    prefs?.setString("locale", locale.languageCode);
    _locale = locale;
    notifyListeners();
  }

  void setUnit(Units unit) {
    String u = "metric";
    if (unit == Units.imperial) {
      u = "imperial";
    }
    prefs?.setString("unit", u);
    _unit = unit;
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
