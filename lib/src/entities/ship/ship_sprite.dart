import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';
import 'exhaust.dart';
import 'ship.dart';

class ShipSprite extends PositionedEntity {
  ShipSprite({
    super.anchor = Anchor.center,
    required super.position,
  }) : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(RectangleHitbox(
        anchor: Anchor.center,
        size: Vector2(28, 56),
        position: Vector2(56, 56) / 2,
      )),
    ];
  }

  final assetsController = locator.assetsController;

  late final Exhaust exhaust;

  @override
  void onLoad() {
    size = Vector2(56, 56);
    final sprite = SpriteComponent(
      sprite: Sprite(
        assetsController.rocket,
      ),
      size: Vector2(56, 56),
      anchor: Anchor.center,
      position: size / 2,
    );
    exhaust = Exhaust(
      position: Vector2(size.x / 2, size.y),
    );

    add(exhaust);
    add(sprite);
  }

  Ship get ship => parent as Ship;
}
