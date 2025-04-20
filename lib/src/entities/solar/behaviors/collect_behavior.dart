import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../ship/ship_sprite.dart';
import '../solar.dart';

class CollectBehavior extends CollisionBehavior<ShipSprite, Solar> {
  @override
  void onCollision(Set<Vector2> intersectionPoints, ShipSprite other) {
    super.onCollision(intersectionPoints, other);
    parent.removeFromParent();
  }
}
