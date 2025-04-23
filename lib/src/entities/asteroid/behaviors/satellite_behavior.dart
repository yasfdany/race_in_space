import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../asteroid.dart';
import 'floaty_behavior.dart';

class SatelliteBehavior extends Behavior<Asteroid> {
  Vector2 center;
  double radius;
  SatelliteBehavior({
    required this.center,
    required this.radius,
  });

  @override
  void onMount() {
    super.onMount();
    parent.findBehavior<FloatyBehavior>().removeFromParent();
  }

  @override
  void update(double dt) {
    super.update(dt);
    parent.angle += dt * 0.5;
    double x = radius * cos(parent.angle);
    double y = radius * sin(parent.angle);
    parent.position = Vector2(
      x + center.x,
      y + center.y,
    );
  }
}
