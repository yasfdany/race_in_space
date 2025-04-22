import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'behaviors/collect_behavior.dart';
import 'shaders/solar_shader.dart';

class Solar extends PositionedEntity with HasGameReference<GameScene> {
  Solar({
    required super.position,
    super.angle = 0,
  }) : super(behaviors: _buildBehaviors);

  final _lightSource = Paint()
    ..color = Colors.deepOrange
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      CollectBehavior(),
    ];
  }

  @override
  void onLoad() {
    anchor = Anchor.center;
    size = Vector2.all(18);
    add(SolarShader(size: size));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      _lightSource,
    );
  }
}
