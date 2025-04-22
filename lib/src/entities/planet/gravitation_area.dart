import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../ui/scenes/game/game_scene.dart';
import 'behaviors/gravity_behavior.dart';
import 'gravitation_bubble.dart';
import 'planet.dart';

class GravitationArea extends PositionedEntity
    with HasGameReference<GameScene> {
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
    ];
  }

  @override
  void onLoad() {
    size = Vector2.all(radius * 2);
    add(GravitationBubble(
      size: size,
      color: game.background.color,
    ));
  }

  Planet get planet => parent as Planet;
}
