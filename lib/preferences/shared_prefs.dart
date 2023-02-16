import 'package:shared_preferences/shared_preferences.dart';

import 'iprefs.dart';

class SharedPrefs implements IPrefs {
  static final _instance = SharedPrefs._internal();
  late SharedPreferences _sharedPrefs;

  SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  @override
  String? getString(String key) {
    return _sharedPrefs.getString(key);
  }

  @override
  Future<IPrefs> get instance async {
    _sharedPrefs = await SharedPreferences.getInstance();
    return _instance;
  }

  @override
  Future setString(String key, String value) async {
    await _sharedPrefs.setString(key, value);
  }

  @override
  Future init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }
}
