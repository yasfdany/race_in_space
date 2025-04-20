import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'behaviors/collect_behavior.dart';

class Solar extends PositionedEntity with HasGameReference<GameScene> {
  Solar({
    required super.position,
    super.angle = 0,
  }) : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      CollectBehavior(),
    ];
  }

  @override
  void onLoad() {
    anchor = Anchor.center;
    size = Vector2.all(24);
    add(CircleComponent(
      anchor: Anchor.center,
      radius: 12,
      position: size / 2,
      paint: Paint()..color = Colors.orange,
    ));
  }
}
