import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';
import '../../utils/helpers/random_helper.dart';
import 'behaviors/collide_behavior.dart';
import 'behaviors/floaty_behavior.dart';

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
      FloatyBehavior(),
      // DragBehavior(),
    ];
  }

  @override
  void onLoad() {
    anchor = Anchor.center;
    size = Vector2.all(40);
    final variant = RandomHelper.rangeInt(
      min: 0,
      max: 15,
    );
    add(SpriteComponent(
      size: size * RandomHelper.rangeDouble(min: 1.9, max: 2.2),
      anchor: Anchor.center,
      position: size / 2,
      sprite: Sprite(
        assetsController.asteroids,
        srcPosition: Vector2(100.0 * variant, 0),
        srcSize: Vector2.all(100.0),
      ),
    ));
  }
}
