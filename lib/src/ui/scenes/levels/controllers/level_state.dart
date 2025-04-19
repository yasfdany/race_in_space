import 'package:flutter/foundation.dart';

import '../../../../entities/level/level.dart';
import '../../game/levels/gravity.dart';
import '../../game/levels/solar_energy.dart';

class LevelState extends ChangeNotifier {
  final _levels = <Level>[
    SolarEnergy(),
    Gravity(),
  ];
  List<Level> get levels => _levels;
  set levels(List<Level> value) {
    _levels.clear();
    _levels.addAll(value);
    notifyListeners();
  }
}
