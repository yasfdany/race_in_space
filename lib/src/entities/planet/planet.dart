import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import 'behaviors/collide_behavior.dart';
import 'gravitation_area.dart';

class Planet extends PositionedEntity {
  Planet({
    this.radius = 0,
    this.gravityArea = 0,
    super.position,
    super.anchor = Anchor.center,
  }) : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      CollideBehavior(),
      // DragBehavior(),
    ];
  }

  double radius;
  int gravityArea;

  @override
  void onLoad() {
    size = Vector2.all(radius * 2);
    add(GravitationArea(
      position: size / 2,
      radius: radius * gravityArea,
    ));
    add(CircleComponent(
      anchor: Anchor.center,
      radius: radius,
      position: size / 2,
      paint: Paint()..color = Colors.white,
    ));
  }
}
