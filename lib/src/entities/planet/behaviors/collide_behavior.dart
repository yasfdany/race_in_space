import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../ship/ship.dart';
import '../planet.dart';

class CollideBehavior extends CollisionBehavior<Ship, Planet> {
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Ship other) {
    super.onCollisionStart(intersectionPoints, other);
    other.reset();
  }
}
