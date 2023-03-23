import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  SharedPreferences? prefs;

  Locale get locale => _locale ?? const Locale("en", "");

  LocaleProvider() {
    readLocale();
  }

  Future<void> readLocale() async {
    prefs = await SharedPreferences.getInstance();
    String? localeStr = prefs?.getString("locale");

    if (localeStr != null) {
      _locale = Locale(localeStr, "");
    } else {
      _locale = const Locale("en", "");
    }
  }

  void setLocale(Locale locale) async {
    prefs?.setString("locale", locale.languageCode);
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
