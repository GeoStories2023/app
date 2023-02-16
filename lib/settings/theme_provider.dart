import 'package:flutter/material.dart';

import '../preferences/iprefs.dart';
import '../preferences/prefs_factory.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  IPrefs? prefs;

  ThemeProvider();

  ThemeMode get theme => _themeMode ?? ThemeMode.dark;

  Future<void> readTheme() async {
    prefs = PrefsFactory().prefs;
    await prefs?.init();
    String? themeStr = prefs?.getString("theme");

    if (themeStr == "dark") {
      _themeMode = ThemeMode.dark;
    } else if (themeStr == "light") {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
  }

  void setTheme(ThemeMode theme) async {
    prefs?.setString("theme", theme.name);
    _themeMode = theme;
    notifyListeners();
  }
}
