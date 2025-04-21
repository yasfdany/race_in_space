import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import 'behaviors/collide_behavior.dart';
import 'behaviors/drag_behavior.dart';
import 'gas_planet.dart';
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
      DragBehavior(),
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
    add(GasPlanet(
      size: size,
    ));
  }
}
