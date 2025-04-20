import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../ship/ship_sprite.dart';
import '../planet.dart';

class CollideBehavior extends CollisionBehavior<ShipSprite, Planet> {
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, ShipSprite other) {
    super.onCollisionStart(intersectionPoints, other);
    other.ship.reset();
  }
}
