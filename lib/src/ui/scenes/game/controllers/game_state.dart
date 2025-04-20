import 'package:flutter/foundation.dart';

import '../../../../entities/level/level.dart';
import '../levels/solar_energy.dart';

class GameState extends ChangeNotifier {
  Level _level = SolarEnergy();
  Level get level => _level;
  set level(Level value) {
    _level = value;
    notifyListeners();
  }

  late int _attempts = _level.attempts;
  int get attempts => _attempts;
  set attempts(int value) {
    _attempts = value;
    notifyListeners();
  }

  late int _solarCollected = 0;
  int get solarCollected => _solarCollected;
  set solarCollected(int value) {
    _solarCollected = value;
    notifyListeners();
  }
}
