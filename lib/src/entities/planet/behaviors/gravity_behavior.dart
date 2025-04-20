import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../ship/ship.dart';
import '../../ship/ship_sprite.dart';
import '../gravitation_area.dart';

class GravityBehavior extends CollisionBehavior<ShipSprite, GravitationArea> {
  Ship? ship;

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, ShipSprite other) {
    super.onCollisionStart(intersectionPoints, other);
    ship = other.ship;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (ship == null) return;

    final toCenter = parent.planet.position - ship!.position;
    final distance = toCenter.length;

    if (distance < parent.radius) {
      final gravityDirection = toCenter.normalized();
      final gravityForce = gravityDirection * dt * 1000;
      ship!.velocity += gravityForce;
    }
  }
}
