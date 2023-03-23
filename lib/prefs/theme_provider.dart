import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  SharedPreferences? prefs;

  ThemeProvider();

  ThemeMode get theme => _themeMode ?? ThemeMode.light;

  Future<void> readTheme() async {
    prefs ??= await SharedPreferences.getInstance();
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
