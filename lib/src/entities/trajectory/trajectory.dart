import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import '../ship/ship.dart';
import 'behaviors/aim_behavior.dart';

class Trajectory extends PositionedEntity {
  Trajectory({
    super.position,
    super.anchor = Anchor.center,
    required this.index,
  }) : super(behaviors: [AimBehavior()]);

  final int index;

  @override
  void onLoad() {
    size = Vector2.all(5);
    add(CircleComponent(
      radius: 2.5,
      position: size / 2,
      paint: Paint()..color = Colors.white,
      anchor: Anchor.center,
    ));
  }

  Ship get ship => parent as Ship;
}
