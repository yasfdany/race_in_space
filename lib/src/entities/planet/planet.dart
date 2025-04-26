import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'behaviors/collide_behavior.dart';
import 'behaviors/drag_behavior.dart';
import 'gravitation_area.dart';
import 'shaders/dry_planet_shader.dart';
import 'shaders/gas_planet_shader.dart';

enum PlanetType {
  gas,
  dry,
}

class Planet extends PositionedEntity {
  Planet({
    this.radius = 0,
    this.gravityArea = 0,
    super.position,
    this.color = Colors.grey,
    this.type = PlanetType.dry,
    super.anchor = Anchor.center,
  }) : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      CollideBehavior(),
      if (kDebugMode) DragBehavior(),
    ];
  }

  PlanetType type;
  double radius;
  int gravityArea;
  Color color;

  @override
  void onLoad() {
    size = Vector2.all(radius * 2);
    add(GravitationArea(
      position: size / 2,
      radius: radius * gravityArea,
    ));
    switch (type) {
      case PlanetType.gas:
        add(GasPlanetShader(
          size: size,
          color: color,
        ));
      case PlanetType.dry:
        add(DryPlanetShader(
          size: size,
          color: color,
        ));
    }
  }
}
