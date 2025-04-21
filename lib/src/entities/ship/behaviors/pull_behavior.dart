import 'dart:math';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

import '../../../../main.dart';
import '../../../ui/scenes/game/controllers/game_state.dart';
import '../ship.dart';

class PullBehavior extends DraggableBehavior<Ship> {
  final _gameState = locator.get<GameState>();

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (parent.state == ShipState.moving) return;
    parent.position.add(event.localDelta);

    final direction = parent.position - parent.startPosition;
    if (direction.length > 0) {
      parent.shipSprite.angle = atan2(-direction.y, -direction.x) + tau / 4;
    }

    double distance =
        parent.startPosition.distanceTo(parent.position).clamp(0, 100);
    _gameState.aimVelocity =
        -(parent.position - parent.startPosition).normalized() * distance * 5;

    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    if (parent.state == ShipState.moving) return;
    parent.state = ShipState.moving;
    double distance =
        parent.startPosition.distanceTo(parent.position).clamp(0, 100);
    parent.velocity =
        -(parent.position - parent.startPosition).normalized() * distance * 5;
    _gameState.aimVelocity = Vector2.zero();

    super.onDragEnd(event);
  }
}
