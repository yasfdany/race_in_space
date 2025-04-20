import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../main.dart';
import '../../config/di/get_it_ext.dart';
import '../../ui/scenes/game/game_scene.dart';
import 'behaviors/pull_behavior.dart';
import 'behaviors/velocity_behavior.dart';

enum ShipState {
  idle,
  moving,
}

class Ship extends PositionedEntity with HasGameReference<GameScene> {
  Ship() : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      PropagatingCollisionBehavior(CircleHitbox()),
      GravityBehavior(),
      PullBehavior(),
    ];
  }

  final assetsController = locator.assetsController;

  late SpriteComponent spriteComponent;

  Vector2 velocity = Vector2(0, 0);
  ShipState state = ShipState.idle;

  late final startPosition = Vector2(
    0,
    (game.size.y / 3),
  );

  @override
  void onLoad() {
    size = Vector2(56, 56);
    anchor = Anchor.center;
    position = Vector2(
      0,
      (game.size.y / 3),
    );
    spriteComponent = SpriteComponent(
      sprite: Sprite(
        assetsController.rocket,
        srcSize: Vector2(56, 56),
      ),
      size: Vector2(56, 56),
      anchor: Anchor.center,
      position: size / 2,
    );
    add(spriteComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (velocity.length > 0) {
      spriteComponent.angle = atan2(velocity.y, velocity.x) + tau / 4;
      state = ShipState.moving;
    }
    final viewportSize = (game.size / 2) / game.camera.viewfinder.zoom;
    if (position.x > viewportSize.x ||
        position.x < -viewportSize.x ||
        position.y > viewportSize.y ||
        position.y < -viewportSize.y) {
      reset();
    }
  }

  void reset() {
    position = Vector2(
      0,
      (game.size.y / 3),
    );
    spriteComponent.angle = 0;
    velocity = Vector2(0, 0);
    state = ShipState.idle;
  }
}
