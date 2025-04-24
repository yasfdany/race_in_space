import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../ship.dart';

class VelocityBehavior extends Behavior<Ship> {
  final audioController = locator.audioController;

  @override
  void update(double dt) {
    super.update(dt);
    parent.position += parent.velocity * dt;

    if (audioController.rocketLaunchHandle != null) {
      SoLoud.instance.set3dSourcePosition(
        audioController.rocketLaunchHandle!,
        parent.position.x,
        parent.position.y,
        0,
      );
    }

    if (audioController.combustHandle != null) {
      SoLoud.instance.set3dSourcePosition(
        audioController.combustHandle!,
        parent.position.x,
        parent.position.y,
        0,
      );
    }
  }
}
