import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../ui/scenes/game/controllers/game_state.dart';
import '../ship.dart';

class PullBehavior extends DraggableBehavior<Ship> {
  final gameState = locator.get<GameState>();
  final audioController = locator.audioController;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (parent.state == ShipState.moving) return;
    parent.position.add(event.localDelta);

    final direction = parent.position - parent.startPosition;
    if (direction.length > 0) {
      parent.shipSprite.angle = atan2(-direction.y, -direction.x) + tau / 4;
    }

    final distance =
        parent.startPosition.distanceTo(parent.position).clamp(0.0, 100.0);
    gameState.aimVelocity =
        -(parent.position - parent.startPosition).normalized() * distance * 5;

    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (parent.state == ShipState.moving) return;
    audioController.playRocketLaunch();
    audioController.playCombust();

    parent.state = ShipState.moving;
    final distance =
        parent.startPosition.distanceTo(parent.position).clamp(0.0, 100.0);
    parent.velocity =
        -(parent.position - parent.startPosition).normalized() * distance * 5;
    gameState.aimVelocity = Vector2.zero();
    parent.shipSprite.exhaust.playing = true;
    parent.shipSprite.exhaust.scale = Vector2.all(
      (parent.velocity.y / 200).abs().clamp(0, 1.2),
    );

    super.onDragEnd(event);
  }
}
