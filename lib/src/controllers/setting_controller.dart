import 'package:flutter/foundation.dart';

class SettingController extends ChangeNotifier {
  double _volume = 1.0;
  double get volume => _volume;
  set volume(double value) {
    _volume = value;
    notifyListeners();
  }

  double _sfxVolume = 1.0;
  double get sfxVolume => _sfxVolume;
  set sfxVolume(double value) {
    _sfxVolume = value;
    notifyListeners();
  }
}
