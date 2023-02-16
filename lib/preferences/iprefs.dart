abstract class IPrefs {
  Future<IPrefs> get instance;

  String? getString(String key);

  Future setString(String key, String value);

  Future init();
}
