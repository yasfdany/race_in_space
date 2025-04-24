import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';

import '../../ui/scenes/game/game_scene.dart';
import '../../utils/helpers/random_helper.dart';
import 'behaviors/collect_behavior.dart';
import 'behaviors/floaty_behavior.dart';
import 'shaders/solar_shader.dart';

class Solar extends PositionedEntity with HasGameReference<GameScene> {
  Solar({
    required super.position,
    super.angle = 0,
    this.index = 0,
  }) : super(behaviors: _buildBehaviors);

  int index;
  bool collected = false;

  final _lightSource = Paint()
    ..color = Colors.deepOrange.withValues(alpha: 0.8)
    ..maskFilter = MaskFilter.blur(
      BlurStyle.normal,
      RandomHelper.rangeDouble(
        min: 5,
        max: 8,
      ),
    );

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      CollectBehavior(),
      FloatyBehavior()
    ];
  }

  @override
  void onLoad() {
    anchor = Anchor.center;
    size = Vector2.all(20);
    scale = Vector2.zero();
    add(SolarShader(size: size));
    add(ScaleEffect.to(
      Vector2.all(1),
      EffectController(
        startDelay: index * 0.1,
        duration: 0.8,
        curve: Curves.elasticOut,
      ),
    ));
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
