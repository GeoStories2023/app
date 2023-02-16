import 'iprefs.dart';
import 'shared_prefs.dart';

class PrefsFactory {
  IPrefs get prefs {
    return SharedPrefs();
  }
}
