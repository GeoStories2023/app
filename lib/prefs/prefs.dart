import 'package:shared_preferences/shared_preferences.dart';

class PrefsProvider {
  late final SharedPreferences prefs;
  static final PrefsProvider _instance = PrefsProvider._internal();

  PrefsProvider._internal();

  factory PrefsProvider() {
    return _instance;
  }

  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();

  Future loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return SharedPreferences.getInstance();
  }
}
