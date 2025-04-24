import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../solar.dart';
import 'floaty_behavior.dart';

class SatelliteBehavior extends Behavior<Solar> {
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

    final x = radius * cos(parent.angle);
    final y = radius * sin(parent.angle);

    parent.position.x = x + center.x;
    parent.position.y = y + center.y;
  }
}
