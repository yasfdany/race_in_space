import 'package:flame_behaviors/flame_behaviors.dart';

import '../ship.dart';

class VelocityBehavior extends Behavior<Ship> {
  @override
  void update(double dt) {
    super.update(dt);
    parent.position += parent.velocity * dt;
  }
}
