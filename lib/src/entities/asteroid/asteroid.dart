import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';
import 'behaviors/collide_behavior.dart';

class Asteroid extends PositionedEntity {
  Asteroid({
    required super.position,
    super.angle = 0,
  }) : super(behaviors: _buildBehaviors);

  final assetsController = locator.assetsController;

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      CollideBehavior(),
      // DragBehavior(),
    ];
  }

  @override
  void onLoad() {
    anchor = Anchor.center;
    size = Vector2.all(40);
    add(SpriteComponent(
      size: size,
      anchor: Anchor.center,
      position: size / 2,
      sprite: Sprite(assetsController.asteroid),
    ));
  }
}
