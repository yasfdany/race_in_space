import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../ship/ship.dart';
import '../solar.dart';

class CollectBehavior extends CollisionBehavior<Ship, Solar> {
  @override
  void onCollision(Set<Vector2> intersectionPoints, Ship other) {
    super.onCollision(intersectionPoints, other);
    parent.removeFromParent();
  }
}
