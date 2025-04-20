import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../ship/ship.dart';
import '../gravitation_area.dart';

class GravityBehavior extends CollisionBehavior<Ship, GravitationArea> {
  Ship? ship;

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Ship other) {
    super.onCollisionStart(intersectionPoints, other);
    ship = other;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final distance =
        (parent.position.distanceTo((ship?.position ?? Vector2.zero())));
    if (distance < parent.radius) {
      ship?.velocity += Vector2.all(parent.radius) * dt;
      ship?.velocity +=
          (parent.position - (ship?.position ?? Vector2.zero())) * dt * 10;
    }
  }
}
