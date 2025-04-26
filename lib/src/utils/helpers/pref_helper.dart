import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  double get animationSpeed {
    return _prefs.getDouble('animationSpeed') ?? 1;
  }

  set animationSpeed(double value) {
    _prefs.setDouble('animationSpeed', value);
  }

  int get lastLevel => _prefs.getInt('last_level') ?? 1;
  set lastLevel(int value) {
    _prefs.setInt('last_level', value);
  }
}
