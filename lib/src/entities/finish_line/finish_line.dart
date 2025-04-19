import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';
import '../../ui/scenes/game/game_scene.dart';
import 'behaviors/finish_behavior.dart';

class FinishLine extends PositionedEntity with HasGameReference<GameScene> {
  FinishLine({
    required super.position,
  }) : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(RectangleHitbox()),
      FinishBehavior(),
    ];
  }

  final assetsController = locator.assetsController;

  @override
  void onLoad() {
    anchor = Anchor.center;
    size = Vector2(game.size.x, 40);
    add(SpriteComponent(
      sprite: Sprite(
        assetsController.finish,
        srcSize: size,
      ),
      size: size,
    ));
  }
}
