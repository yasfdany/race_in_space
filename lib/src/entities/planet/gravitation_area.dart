import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import 'behaviors/drag_behavior.dart';
import 'behaviors/gravity_behavior.dart';

class GravitationArea extends PositionedEntity {
  GravitationArea({
    this.radius = 0,
    super.position,
    super.anchor = Anchor.center,
  }) : super(behaviors: _buildBehaviors);

  double radius;

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      GravityBehavior(),
      DragBehavior(),
    ];
  }

  @override
  void onLoad() {
    size = Vector2.all(radius * 2);
    add(
      CircleComponent(
        anchor: Anchor.center,
        position: size / 2,
        radius: radius,
        paint: Paint()
          ..color = Colors.red.withValues(
            alpha: 0.2,
          ),
      ),
    );
  }
}
