import 'dart:math';

import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';

import '../../../../main.dart';
import '../../../config/di/get_it_ext.dart';
import '../../../ui/scenes/game/controllers/game_state.dart';
import '../../trail/trail.dart';
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
  void onDragEnd(DragEndEvent event) async {
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

    final trails = parent.game.world.children.whereType<Trail>().toList();
    for (final trail in trails) {
      trail.add(OpacityEffect.fadeOut(EffectController(
        duration: 0.5,
        curve: Curves.fastOutSlowIn,
      )));
    }

    // if (parent.position.y < gameState.level.startingPos.y) {
    //   for (var i = 0; i < trails.length - 1; i++) {
    //     await Future.delayed(0.1.seconds);
    //     trails[i].index = i;
    //     trails[i].position = parent.position.clone();
    //     trails[i].updateOpacity();
    //   }
    // }

    super.onDragEnd(event);
  }
}
