import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../main.dart';
import '../../ui/scenes/game/controllers/game_controller.dart';
import '../../ui/scenes/game/game_scene.dart';
import 'behaviors/pull_behavior.dart';
import 'behaviors/velocity_behavior.dart';
import 'ship_sprite.dart';

enum ShipState {
  idle,
  moving,
}

class Ship extends PositionedEntity with HasGameReference<GameScene> {
  Ship({
    super.position,
  }) : super(behaviors: _buildBehaviors);

  static List<Behavior<EntityMixin>> get _buildBehaviors {
    return [
      VelocityBehavior(),
      PullBehavior(),
    ];
  }

  late final _gameController = locator.get<GameController>();

  late ShipSprite shipSprite;

  Vector2 velocity = Vector2(0, 0);
  ShipState state = ShipState.idle;

  late final startPosition = position.clone();

  @override
  void onLoad() {
    size = Vector2(56, 56);
    anchor = Anchor.center;
    shipSprite = ShipSprite(
      position: size / 2,
    );
    add(shipSprite);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (velocity.length > 0) {
      shipSprite.angle = atan2(velocity.y, velocity.x) + tau / 4;
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
    // if (game.overlays.isActive(WinDialog.overlayName)) return;
    position = _gameController.state.level.startingPos;
    shipSprite.angle = 0;
    velocity = Vector2(0, 0);
    state = ShipState.idle;
  }
}
